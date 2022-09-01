import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:provider/provider.dart';

import '../../enums/enums/message_enum.dart';
import '../../models/message.dart';
import '../../provider/other_user_provider.dart';
import '../../provider/user_provider.dart';
import '../../services/chat_repository.dart';
import '../../utils/constants.dart';
import '../../utils/helper_method.dart';
import 'display_text_image_gif.dart';

class ChatList extends StatefulWidget {
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final ChatRepository _chatRepository = ChatRepository();

  final ScrollController messageController = ScrollController();

  late Stream<List<Message>> mydata;

  Stream<List<Message>> getData(BuildContext context) {
    var otherUser = Provider.of<OtherUserProvider>(context, listen: false).user;
    var currentUser = Provider.of<UserProvider>(context, listen: false).user;
    return _chatRepository.getChatStream(
        otherUser.id.toString(), currentUser.id.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mydata = getData(context);
  }

  @override
  Widget build(BuildContext context) {
    var otherUser = Provider.of<OtherUserProvider>(
      context,
    ).user;
    var currentUser = Provider.of<UserProvider>(
      context,
    ).user;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Helper.dynamicWidth(context, 5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Helper.dynamicHeight(context, 50),
            child: StreamBuilder<List<Message>>(
              stream: mydata,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text('Something Went Wrong Try later'));
                    } else {
                      final messages = snapshot.data;
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        messageController
                            .jumpTo(messageController.position.maxScrollExtent);
                      });
                      return messages!.isEmpty
                          ? const Center(child: Text('Say Hi..'))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              controller: messageController,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final messageData = snapshot.data![index];
                                print(messageData.type);
                                var timeSent = DateFormat.Hm()
                                    .format(messageData.timeSent);
                                return messageData.type == MessageEnum.image
                                    ? Align(
                                        alignment: (messageData.senderId !=
                                                currentUser.id.toString()
                                            ? Alignment.topLeft
                                            : Alignment.topRight),
                                        child: SizedBox(
                                          height: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DisplayTextImageGIF(
                                              messageSenderId:
                                                  messageData.senderId,
                                              message: messageData.text,
                                              type: messageData.type,
                                            ),
                                          ),
                                        ),
                                      )
                                    : messageData.type == MessageEnum.audio
                                        ? Align(
                                            alignment: (messageData.senderId !=
                                                    currentUser.id.toString()
                                                ? Alignment.topLeft
                                                : Alignment.topRight),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DisplayTextImageGIF(
                                                messageSenderId:
                                                    messageData.senderId,
                                                message: messageData.text,
                                                type: messageData.type,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: Helper.dynamicWidth(
                                                  context, 2),
                                              vertical: Helper.dynamicHeight(
                                                  context, 1),
                                            ),
                                            child: Align(
                                              alignment: (messageData
                                                          .senderId !=
                                                      currentUser.id.toString()
                                                  ? Alignment.topLeft
                                                  : Alignment.topRight),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color:
                                                      (messageData.senderId !=
                                                              currentUser.id
                                                                  .toString()
                                                          ? Colors.grey.shade200
                                                          : Colors.blue[100]),
                                                ),
                                                padding: EdgeInsets.all(
                                                    Helper.dynamicFont(
                                                        context, 1)),
                                                child: TextWidget(
                                                  text: messageData.text,
                                                  color: R.color.dark_black,
                                                ),
                                              ),
                                            ),
                                          );
                              },
                            );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
