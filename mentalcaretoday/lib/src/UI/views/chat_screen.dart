import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/chat_footer.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ];
  final TextEditingController _messageController = TextEditingController();

  FocusNode messageNode = FocusNode();

  unfocusTextFields() {
    if (messageNode.hasFocus) {
      messageNode.unfocus();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();

    messageNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: SingleChildScrollView(
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
                                "https://i.pinimg.com/550x/19/1d/ec/191dec566460c22368513a9e827a5c33.jpg",
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
                            const AppBarTextHeadLine(
                              text: "Martha Craig",
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
                              "https://i.pinimg.com/564x/1e/88/93/1e889313773c6f02fe21a878d73d437f.jpg",
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
                        child: const AppBarTextHeadLine(
                          text: "Martha Craig",
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
                            "https://i.pinimg.com/550x/19/1d/ec/191dec566460c22368513a9e827a5c33.jpg",
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
                            color: const Color.fromRGBO(244, 252, 255, 1.0),
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
                              "https://i.pinimg.com/550x/19/1d/ec/191dec566460c22368513a9e827a5c33.jpg",
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
                          text: "Say hi to your new Facebook friend, Isabella",
                          color: R.color.normalTextColor,
                          fontSize: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Helper.dynamicWidth(context, 5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Helper.dynamicHeight(context, 50),
                        child: ListView.builder(
                          itemCount: messages.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Helper.dynamicWidth(context, 2),
                                vertical: Helper.dynamicHeight(context, 1),
                              ),
                              child: Align(
                                alignment:
                                    (messages[index].messageType == "receiver"
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (messages[index].messageType ==
                                            "receiver"
                                        ? Colors.grey.shade200
                                        : Colors.blue[100]),
                                  ),
                                  padding: EdgeInsets.all(
                                      Helper.dynamicFont(context, 1)),
                                  child: TextWidget(
                                    text: messages[index].messageContent,
                                    color: R.color.dark_black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ChatFooter(
                    textController: _messageController,
                    onPressSend: () {},
                    node: messageNode,
                    onPressGift: () {}),
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
