import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class ShowDialogBox {
  static void dialogBox(context, title, content,
      {required Function onPress, required Function onCancel}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("No",
                        style: TextStyle(
                          color: Colors.red,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel();
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text(
                      "Yes",
                    ),
                    onPressed: () {
                      onPress();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onCancel();
                    },
                    child: const Text('No',
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      onPress();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
      },
    );
  }

  static customDialogBoxTwoButtons(
    context,
    title,
    subtitle,
    bText1,
    bText2, {
    required Function onPressB1,
    required Function onPressB2,
    String? imagePath,
    double boxMinHeight = 32,
    double boxMaxHeight = 32,
    double boxWidth = 100,
    double boxSymetricPadding = 2,
    bool isImageVisible = true,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  }) {
    showDialog(
      context: context,
      // barrierColor: Colors.black38.withOpacity(0.8),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
            constraints: BoxConstraints(
              minHeight: Helper.dynamicHeight(context, boxMinHeight),
              maxHeight: Helper.dynamicHeight(context, boxMaxHeight),
            ),
            width: Helper.dynamicWidth(context, boxWidth),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: R.color.white,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  Visibility(
                    visible: isImageVisible,
                    child: SvgPicture.asset(
                      imagePath!,
                      width: Helper.dynamicHeight(context, 8),
                      height: Helper.dynamicHeight(context, 8),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          Helper.dynamicWidth(context, boxSymetricPadding),
                    ),
                    child: Center(
                      child: TextWidget(
                        textAlign: TextAlign.center,
                        text: title,
                        color: R.color.dark_black,
                        fontSize: 1.6,
                        fontFamily: R.fonts.ralewayBold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          Helper.dynamicWidth(context, boxSymetricPadding),
                    ),
                    child: Center(
                      child: TextWidget(
                        textAlign: TextAlign.center,
                        text: subtitle,
                        color: R.color.headingTexColor,
                        fontSize: 1.2,
                        fontFamily: R.fonts.ralewayRegular,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWithGradientBackground(
                        text: bText1,
                        color: R.color.headingTexColor,
                        onPressed: onPressB1,
                        buttonWidth: 30,
                        buttonHeight: 6,
                        fontSize: 1.2,
                        radius: 30,
                        linearGradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(235, 234, 236, 1.0),
                            Color.fromRGBO(235, 234, 236, 1.0),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      SizedBox(
                        width: Helper.dynamicWidth(context, 5),
                      ),
                      ButtonWithGradientBackground(
                        text: bText2,
                        onPressed: onPressB2,
                        buttonWidth: 30,
                        buttonHeight: 6,
                        fontSize: 1.2,
                        radius: 30,
                        linearGradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(141, 227, 216, 1.0),
                            Color.fromRGBO(126, 194, 220, 1.0),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: Helper.dynamicHeight(context, 5),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static feedbackDialogBox(
    context,
    title,
    bText1,
    bText2, {
    required Function onPressB1,
    required Function onPressB2,
    TextEditingController? controller,
    required String imagePath,
    double boxMinHeight = 40,
    double boxMaxHeight = 40,
    double boxWidth = 100,
    double boxSymetricPadding = 2,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  }) {
    showDialog(
      context: context,
      // barrierColor: Colors.black38.withOpacity(0.8),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
            constraints: BoxConstraints(
              minHeight: Helper.dynamicHeight(context, boxMinHeight),
              maxHeight: Helper.dynamicHeight(context, boxMaxHeight),
            ),
            width: Helper.dynamicWidth(context, boxWidth),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: R.color.white,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  SvgPicture.asset(
                    imagePath,
                    width: Helper.dynamicHeight(context, 8),
                    height: Helper.dynamicHeight(context, 8),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          Helper.dynamicWidth(context, boxSymetricPadding),
                    ),
                    child: Center(
                      child: TextWidget(
                        textAlign: TextAlign.center,
                        text: title,
                        color: R.color.dark_black,
                        fontSize: 1.4,
                        fontFamily: R.fonts.ralewayBold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Helper.dynamicWidth(context, 5)),
                    child: TextFieldWithIcon(
                      onChanged: ((p0) {}),
                      controller: controller,
                      placeHolder: "Share your thought",
                      maxLines: 3,
                      minLines: 3,
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWithGradientBackground(
                        text: bText1,
                        color: R.color.headingTexColor,
                        onPressed: onPressB1,
                        buttonWidth: 30,
                        buttonHeight: 6,
                        fontSize: 1.2,
                        radius: 30,
                        linearGradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(235, 234, 236, 1.0),
                            Color.fromRGBO(235, 234, 236, 1.0),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      SizedBox(
                        width: Helper.dynamicWidth(context, 5),
                      ),
                      ButtonWithGradientBackground(
                        text: bText2,
                        onPressed: onPressB2,
                        buttonWidth: 30,
                        buttonHeight: 6,
                        fontSize: 1.2,
                        radius: 30,
                        linearGradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(141, 227, 216, 1.0),
                            Color.fromRGBO(126, 194, 220, 1.0),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: Helper.dynamicHeight(context, 5),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static saveRecordingDialogBox(
    context,
    title,
    subtitle,
    bText1,
    bText2, {
    required Function onPressB1,
    required Function onPressB2,
    TextEditingController? controller,
    required String imagePath,
    double boxMinHeight = 38,
    double boxMaxHeight = 38,
    double boxWidth = 100,
    double boxSymetricPadding = 2,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  }) {
    showDialog(
      context: context,
      // barrierColor: Colors.black38.withOpacity(0.8),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
            constraints: BoxConstraints(
              minHeight: Helper.dynamicHeight(context, boxMinHeight),
              maxHeight: Helper.dynamicHeight(context, boxMaxHeight),
            ),
            width: Helper.dynamicWidth(context, boxWidth),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: R.color.white,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  SvgPicture.asset(
                    imagePath,
                    width: Helper.dynamicHeight(context, 8),
                    height: Helper.dynamicHeight(context, 8),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          Helper.dynamicWidth(context, boxSymetricPadding),
                    ),
                    child: Center(
                      child: TextWidget(
                        textAlign: TextAlign.center,
                        text: title,
                        color: R.color.dark_black,
                        fontSize: 1.4,
                        fontFamily: R.fonts.ralewayBold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          Helper.dynamicWidth(context, boxSymetricPadding),
                    ),
                    child: Center(
                      child: TextWidget(
                        textAlign: TextAlign.center,
                        text: subtitle,
                        color: R.color.headingTexColor,
                        fontSize: 1.2,
                        fontFamily: R.fonts.ralewayRegular,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Helper.dynamicWidth(context, 10)),
                    child: SimpleTextField(
                      controller: controller,
                      placeHolder: "Enter the name of Affirmations",
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWithGradientBackground(
                        text: bText1,
                        color: R.color.headingTexColor,
                        onPressed: onPressB1,
                        buttonWidth: 30,
                        buttonHeight: 6,
                        fontSize: 1.2,
                        radius: 30,
                        linearGradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(235, 234, 236, 1.0),
                            Color.fromRGBO(235, 234, 236, 1.0),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      SizedBox(
                        width: Helper.dynamicWidth(context, 5),
                      ),
                      ButtonWithGradientBackground(
                        text: bText2,
                        onPressed: onPressB2,
                        buttonWidth: 30,
                        buttonHeight: 6,
                        fontSize: 1.2,
                        radius: 30,
                        linearGradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(141, 227, 216, 1.0),
                            Color.fromRGBO(126, 194, 220, 1.0),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: Helper.dynamicHeight(context, 5),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static customDialogBoxOneButton(
    context,
    title,
    subtitle,
    bText2, {
    required Function onPressB2,
    String? imagePath,
    double boxMinHeight = 32,
    double boxMaxHeight = 32,
    double boxWidth = 100,
    double boxSymetricPadding = 2,
    bool isImageVisible = true,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  }) {
    showDialog(
      context: context,
      // barrierColor: Colors.black38.withOpacity(0.8),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
            constraints: BoxConstraints(
              minHeight: Helper.dynamicHeight(context, boxMinHeight),
              maxHeight: Helper.dynamicHeight(context, boxMaxHeight),
            ),
            width: Helper.dynamicWidth(context, boxWidth),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: R.color.white,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  Visibility(
                    visible: isImageVisible,
                    child: SvgPicture.asset(
                      imagePath!,
                      width: Helper.dynamicHeight(context, 8),
                      height: Helper.dynamicHeight(context, 8),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          Helper.dynamicWidth(context, boxSymetricPadding),
                    ),
                    child: Center(
                      child: TextWidget(
                        textAlign: TextAlign.center,
                        text: title,
                        color: R.color.dark_black,
                        fontSize: 1.6,
                        fontFamily: R.fonts.ralewayBold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          Helper.dynamicWidth(context, boxSymetricPadding),
                    ),
                    child: Center(
                      child: TextWidget(
                        textAlign: TextAlign.center,
                        text: subtitle,
                        color: R.color.headingTexColor,
                        fontSize: 1.2,
                        fontFamily: R.fonts.ralewayRegular,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  ButtonWithGradientBackground(
                    text: bText2,
                    onPressed: onPressB2,
                    buttonWidth: 30,
                    buttonHeight: 6,
                    fontSize: 1.2,
                    radius: 30,
                    linearGradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(141, 227, 216, 1.0),
                        Color.fromRGBO(126, 194, 220, 1.0),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  // SizedBox(
                  //   height: Helper.dynamicHeight(context, 5),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void customDialogBoxWithTextField(
    context,
    formKEY,
    title, {
    required Function onSubmit,
    double boxWidth = 100,
    bool isDismissAble = true,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    required FocusNode node,
    required TextEditingController controller,
    String buttonText = 'Submit',
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black38.withOpacity(0.8),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding:
              EdgeInsets.symmetric(horizontal: Helper.dynamicWidth(context, 5)),
          content: Form(
            key: formKEY,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              width: Helper.dynamicWidth(context, boxWidth),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(254, 245, 245, 1),
              ),
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: isDismissAble,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButtonWithGradientBackground(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        linearGradient: const LinearGradient(
                            colors: [Colors.transparent, Colors.transparent]),
                        icon: Icons.close,
                        iconColor: Colors.green,
                      ),
                    ),
                  ),
                  Center(
                    child: TextWidget(
                      textAlign: TextAlign.center,
                      text: title,
                      color: Colors.yellow,
                      // fontFamily: 'HalveticaNeueMedium',
                      fontSize: 1.8,
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Helper.dynamicWidth(
                      context,
                      10,
                    )),
                    child: Container(
                      // decoration: node.hasPrimaryFocus
                      //     ? _boxDecoration()
                      //     : BoxDecoration(),
                      child: TextFieldBio(
                        controller: controller,
                        node: node,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 2),
                  ),
                  ButtonWithGradientBackground(
                    text: buttonText,
                    onPressed: () => onSubmit(context),
                    buttonWidth: 40,
                    fontSize: 1.5,
                    radius: 30,
                    alignmentBegin: Alignment.centerLeft,
                    alignmentEnd: Alignment.centerRight,
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 2),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// BoxDecoration _boxDecoration() {
//   return BoxDecoration(
//     borderRadius: BorderRadius.circular(40),
//     boxShadow: const [
//       BoxShadow(
//         spreadRadius: 0.1,
//         color: Color.fromRGBO(252, 207, 211, 1),
//         blurRadius: 10,
//         offset: Offset(0, -10),
//       ),
//     ],
//   );
// }
