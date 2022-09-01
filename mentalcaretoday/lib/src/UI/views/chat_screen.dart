import 'dart:io';

import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/chat_footer.dart';
import 'package:mentalcaretoday/src/UI/widgets/chat_list.dart';
import 'package:mentalcaretoday/src/UI/widgets/display_text_image_gif.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../enums/enums/message_enum.dart';
import '../../models/message.dart';
import '../../provider/other_user_provider.dart';
import '../../provider/user_provider.dart';
import '../../services/auth_services.dart';
import '../../services/chat_repository.dart';
import '../../utils/utils.dart';

class ChatScreen extends StatefulWidget {
  final String recieverUserId;
  const ChatScreen({Key? key, required this.recieverUserId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatRepository _chatRepository = ChatRepository();
  Future<void> sendMessage() async {
    if (isShowSendButton) {
      _chatRepository.sendTextMessage(
        context: context,
        text: _messageController.text.trim(),
        recieverUserId: widget.recieverUserId,
      );
      setState(() {
        _messageController.text = "";
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder?.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _soundRecorder?.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    _chatRepository.sendFileMessage(
        context: context,
        file: file,
        recieverUserId: widget.recieverUserId,
        messageEnum: messageEnum);
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  bool isShowSendButton = false;

  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fechUser();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed!');
    }
    await _soundRecorder?.openRecorder();
    _soundRecorder?.setSubscriptionDuration(const Duration(milliseconds: 500));
    isRecorderInit = true;
  }

  bool isLoading = false;
  void fechUser() async {
    setState(() {
      isLoading = true;
    });
    await authService.getUserDataById(
        context, int.parse(widget.recieverUserId));
    setState(() {
      isLoading = false;
    });
  }

  final TextEditingController _messageController = TextEditingController();
  final ScrollController messageController = ScrollController();

  FocusNode messageNode = FocusNode();

  unfocusTextFields() {
    if (messageNode.hasFocus) {
      messageNode.unfocus();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    messageNode.dispose();
    isRecorderInit = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var otherUser = Provider.of<OtherUserProvider>(
      context,
    ).user;
    var currentUser = Provider.of<UserProvider>(
      context,
    ).user;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: messageNode.hasFocus
                    ? const ScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: InkWell(
                  onTap: () => unfocusTextFields(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Helper.dynamicHeight(context, 42),
                        width: Helper.dynamicWidth(context, 100),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: Helper.dynamicHeight(context, 8),
                              child: SizedBox(
                                width: Helper.dynamicWidth(context, 100),
                                height: Helper.dynamicHeight(context, 45),
                                child: SvgPicture.asset(
                                  R.image.curveImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: Helper.dynamicHeight(context, 5.5),
                              left: Helper.dynamicWidth(context, 3),
                              child: BackArrowButton(
                                ontap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Positioned(
                              top: Helper.dynamicHeight(context, 6),
                              left: Helper.dynamicWidth(context, 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Helper.dynamicFont(context, 13.5)),
                                    child: Image.network(
                                      otherUser.image!,
                                      fit: BoxFit.cover,
                                      // loadingBuilder: (BuildContext context, Widget child,
                                      //     ImageChunkEvent? loadingProgress) {
                                      //   if (loadingProgress == null) return child;
                                      //   return Padding(
                                      //     padding: EdgeInsets.all(Helper.dynamicFont(context, 1.5)),
                                      //     child: SpinKitFadingCube(
                                      //       color: const Color.fromRGBO(248, 45, 75, 1),
                                      //       size: Helper.dynamicFont(context, 3.5),
                                      //     ),
                                      //   );
                                      // },
                                      width: Helper.dynamicWidth(context, 9),
                                      height: Helper.dynamicWidth(context, 9),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Helper.dynamicWidth(context, 1),
                                  ),
                                  AppBarTextHeadLine(
                                    text: otherUser.firstName,
                                    fontSize: 1.5,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: Helper.dynamicHeight(context, 12),
                              left: Helper.dynamicWidth(context, 35),
                              child: SizedBox(
                                height: Helper.dynamicWidth(context, 30),
                                width: Helper.dynamicWidth(context, 30),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    Helper.dynamicFont(context, 8),
                                  ),
                                  child: Image.network(
                                    otherUser.image!,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Padding(
                                        padding: EdgeInsets.all(
                                            Helper.dynamicFont(context, 1.5)),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: Helper.dynamicHeight(context, 30),
                              left: Helper.dynamicWidth(context, 33),
                              child: AppBarTextHeadLine(
                                text: otherUser.firstName,
                                fontSize: 1.7,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Positioned(
                              top: Helper.dynamicHeight(context, 34),
                              left: Helper.dynamicWidth(context, 42),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Helper.dynamicFont(context, 13.5)),
                                child: Image.network(
                                  currentUser.image!,
                                  fit: BoxFit.cover,
                                  // loadingBuilder: (BuildContext context, Widget child,
                                  //     ImageChunkEvent? loadingProgress) {
                                  //   if (loadingProgress == null) return child;
                                  //   return Padding(
                                  //     padding: EdgeInsets.all(Helper.dynamicFont(context, 1.5)),
                                  //     child: SpinKitFadingCube(
                                  //       color: const Color.fromRGBO(248, 45, 75, 1),
                                  //       size: Helper.dynamicFont(context, 3.5),
                                  //     ),
                                  //   );
                                  // },
                                  width: Helper.dynamicWidth(context, 12),
                                  height: Helper.dynamicWidth(context, 12),
                                ),
                              ),
                            ),
                            Positioned(
                              top: Helper.dynamicHeight(context, 33.6),
                              left: Helper.dynamicWidth(context, 49),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(244, 252, 255, 1.0),
                                  borderRadius: BorderRadius.circular(
                                    Helper.dynamicFont(context, 15),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Helper.dynamicWidth(context, 0.8),
                                  vertical: Helper.dynamicWidth(context, 0.8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Helper.dynamicFont(context, 13.5)),
                                  child: Image.network(
                                    otherUser.image!,
                                    fit: BoxFit.cover,
                                    // loadingBuilder: (BuildContext context, Widget child,
                                    //     ImageChunkEvent? loadingProgress) {
                                    //   if (loadingProgress == null) return child;
                                    //   return Padding(
                                    //     padding: EdgeInsets.all(Helper.dynamicFont(context, 1.5)),
                                    //     child: SpinKitFadingCube(
                                    //       color: const Color.fromRGBO(248, 45, 75, 1),
                                    //       size: Helper.dynamicFont(context, 3.5),
                                    //     ),
                                    //   );
                                    // },
                                    width: Helper.dynamicWidth(context, 12),
                                    height: Helper.dynamicWidth(context, 12),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: Helper.dynamicHeight(context, 40),
                              left: Helper.dynamicWidth(context, 18),
                              child: TextWidget(
                                text:
                                    "Say hi to your new Facebook friend, ${otherUser.firstName}",
                                color: R.color.normalTextColor,
                                fontSize: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ChatList(),
                      Stack(
                        children: [
                          ChatFooter(
                              isRecording: isRecording,
                              isShowSendButton: isShowSendButton,
                              textController: _messageController,
                              onPressSend: () {
                                sendMessage();
                              },
                              onChanged: (val) {
                                if (val.isNotEmpty) {
                                  setState(() {
                                    isShowSendButton = true;
                                  });
                                } else {
                                  setState(() {
                                    isShowSendButton = false;
                                  });
                                }
                              },
                              node: messageNode,
                              onPressGift: () {
                                selectImage();
                              }),
                          isRecording
                              ? Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 65, top: 18),
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(141, 227, 216, 1.0),
                                          Color.fromRGBO(126, 194, 220, 1.0),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: StreamBuilder<RecordingDisposition>(
                                      stream: _soundRecorder!.onProgress,
                                      builder: (context, snapshot) {
                                        final duration = snapshot.hasData
                                            ? snapshot.data!.duration
                                            : Duration.zero;
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const BlinkText(
                                              'Recording',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.redAccent),
                                              endColor: Colors.orange,
                                            ),
                                            const SizedBox(
                                              width: 50,
                                            ),
                                            TextWidget(
                                              text: '${duration.inSeconds}',
                                              color: R.color.white,
                                              fontSize: 1.5,
                                            ),
                                          ],
                                        );
                                      }),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
