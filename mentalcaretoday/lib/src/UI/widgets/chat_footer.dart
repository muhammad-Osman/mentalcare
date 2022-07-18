import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class ChatFooter extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onPressSend;
  final FocusNode node;
  final LinearGradient? linearGradient;
  final bool isInvertedGradient;
  final Alignment alignmentBegin;
  final Alignment alignmentEnd;
  final String placeHolder;
  final int maxCharacters;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? cursorColor;
  final VoidCallback onPressGift;
  final Color? placeHolderColor;
  final Color? FooterContainerColor;

  const ChatFooter({
    required this.textController,
    required this.onPressSend,
    required this.node,
    this.linearGradient,
    this.isInvertedGradient = false,
    this.alignmentBegin = Alignment.topCenter,
    this.alignmentEnd = Alignment.bottomCenter,
    this.placeHolder = 'Type a message',
    this.maxCharacters = 500,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.cursorColor,
    required this.onPressGift,
    this.placeHolderColor,
    this.FooterContainerColor = Colors.transparent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Helper.dynamicHeight(context, 9),
      padding: EdgeInsets.only(
        top: Helper.dynamicHeight(context, 0.2),
        left: Helper.dynamicWidth(context, 5),
        right: Helper.dynamicWidth(context, 5),
        bottom: Helper.dynamicHeight(context, 1.5),
      ),
      color: FooterContainerColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 6,
            child: TextFieldWithIcon(
              node: node,
              controller: textController,
              onPressSuffix: () => onPressGift(),
              isSuffixIcon: true,
              imagePath: R.image.attachment,
              imageHeight: 20,
              imageWidth: 20,
              placeHolder: placeHolder,
              textInputDecoration: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxCharacters),
              ],
              borderColor: borderColor,
              textColor: textColor,
              cursorColor: cursorColor,
              placeHolderColor: placeHolderColor,
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: Helper.dynamicHeight(context, 5),
              width: Helper.dynamicHeight(context, 5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(40),
              ),
              child: IconButtonWithGradientBackground(
                onPressed: () => onPressSend(),
                linearGradient: linearGradient,
                icon: Icons.send_rounded,
                iconSize: Helper.dynamicFont(context, 0.13),
                alignmentBegin: alignmentBegin,
                alignmentEnd: alignmentEnd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
