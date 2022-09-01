import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/models/user.dart';
import 'package:mentalcaretoday/src/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';
import '../enums/enums/message_enum.dart';
import '../models/chat_contact.dart';
import '../models/message.dart';
import '../provider/other_user_provider.dart';
import '../provider/user_provider.dart';
import '../utils/utils.dart';
import 'common_firebase_storage_repository.dart';

class ChatRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthService authService = AuthService();
  final CommonFirebaseStorageRepository _storageRepository =
      CommonFirebaseStorageRepository();
  Stream<List<ChatContact>> getChatContacts(BuildContext context) {
    var currentUser = Provider.of<UserProvider>(context, listen: false).user;
    return firestore
        .collection('users')
        .doc(currentUser.id.toString())
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = User.fromMap(userData.data()!);

        contacts.add(
          ChatContact(
            name: user.firstName,
            profilePic: user.image!,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  Stream<List<Message>> getChatStream(
      String recieverUserId, String currentUserId) {
    return firestore
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  void _saveDataToContactsSubcollection(
    BuildContext context,
    String text,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    var senderUserData = Provider.of<UserProvider>(context, listen: false).user;
// users -> reciever user id => chats -> current user id -> set
    authService.getUserDataById(context, int.parse(recieverUserId));
    var otherUser = Provider.of<OtherUserProvider>(context, listen: false).user;
    var recieverChatContact = ChatContact(
      name: senderUserData.firstName,
      profilePic: senderUserData.image!,
      contactId: senderUserData.id.toString(),
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(senderUserData.id.toString())
        .set(
          recieverChatContact.toMap(),
        );
    // users -> current user id  => chats -> reciever user id -> set data
    var senderChatContact = ChatContact(
      name: otherUser.firstName,
      profilePic: otherUser.image!,
      contactId: otherUser.id.toString(),
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('users')
        .doc(senderUserData.id.toString())
        .collection('chats')
        .doc(recieverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessageToMessageSubcollection(
      {required String recieverUserId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required MessageEnum messageType,
      required String username,
      required String senderUsername,
      required String? recieverUserName,
      required BuildContext context}) async {
    var currentUser = Provider.of<UserProvider>(context, listen: false).user;
    final message = Message(
      senderId: currentUser.id.toString(),
      recieverid: recieverUserId,
      type: messageType,
      text: text,
      timeSent: timeSent,
      messageId: messageId,
    );

    // users -> sender id -> reciever id -> messages -> message id -> store message
    await firestore
        .collection('users')
        .doc(currentUser.id.toString())
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
    // users -> eciever id  -> sender id -> messages -> message id -> store message
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(currentUser.id.toString())
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
  }) async {
    var currentUser = Provider.of<UserProvider>(context, listen: false).user;
    authService.getUserDataById(context, int.parse(recieverUserId));
    var otherUser = Provider.of<OtherUserProvider>(context, listen: false).user;
    try {
      var timeSent = DateTime.now();

      var messageId = const Uuid().v1();

      _saveDataToContactsSubcollection(
        context,
        text,
        timeSent,
        recieverUserId,
      );

      _saveMessageToMessageSubcollection(
        context: context,
        recieverUserId: recieverUserId,
        text: text,
        messageType: MessageEnum.text,
        timeSent: timeSent,
        messageId: messageId,
        username: currentUser.firstName,
        recieverUserName: otherUser.firstName,
        senderUsername: currentUser.firstName,
      );
    } catch (e) {
      // showSnackBar(context: context, content: e.toString());
    }
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required MessageEnum messageEnum,
  }) async {
    try {
      var currentUser = Provider.of<UserProvider>(context, listen: false).user;
      authService.getUserDataById(context, int.parse(recieverUserId));
      var otherUser =
          Provider.of<OtherUserProvider>(context, listen: false).user;
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      String imageUrl = await _storageRepository.storeFileToFirebase(
        'chat/${messageEnum.type}/${currentUser.id}/$recieverUserId/$messageId',
        file,
      );

      String contactMsg;

      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.gif:
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }
      _saveDataToContactsSubcollection(
        context,
        contactMsg,
        timeSent,
        recieverUserId,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: imageUrl,
        timeSent: timeSent,
        messageId: messageId,
        username: currentUser.firstName,
        messageType: messageEnum,
        recieverUserName: otherUser.firstName,
        senderUsername: currentUser.firstName,
        context: context,
      );
    } catch (e) {
      // showSnackBar(context: context, content: e.toString());
    }
  }
}
