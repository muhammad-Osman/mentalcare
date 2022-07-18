import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class MusicContainerWithTwoIcons extends StatelessWidget {
  final String text;
  final Function onPressedMusic;
  final Function onPressedCross;
  final double radius;
  final double buttonWidth;
  final double buttonHeight;
  final Alignment alignmentBegin;
  final Alignment alignmentEnd;
  final double fontSize;
  final FontWeight fontWeight;

  final bool regularFont;
  final LinearGradient linearGradient;
  final Color color;
  final bool isBoxShadow;
  final double imageHeight;
  final double imagewidth;

  const MusicContainerWithTwoIcons({
    Key? key,
    required this.text,
    required this.onPressedCross,
    required this.onPressedMusic,
    this.radius = 30.0,
    this.buttonWidth = 90,
    this.buttonHeight = 7,
    this.alignmentBegin = Alignment.topCenter,
    this.alignmentEnd = Alignment.bottomCenter,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 1,
    this.regularFont = false,
    this.linearGradient = const LinearGradient(
      colors: [
        Color.fromRGBO(255, 255, 255, 1.0),
        Color.fromRGBO(255, 255, 255, 1.0),
      ],
    ),
    this.color = Colors.black,
    this.isBoxShadow = true,
    this.imageHeight = 4.0,
    this.imagewidth = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.dynamicHeight(context, buttonHeight),
      width: Helper.dynamicWidth(context, buttonWidth),
      decoration: BoxDecoration(
        gradient: linearGradient,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius:
            BorderRadius.circular(Helper.dynamicFont(context, radius)),
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(Helper.dynamicFont(context, radius)),
        child: Material(
          color: Colors.transparent,
          borderRadius:
              BorderRadius.circular(Helper.dynamicFont(context, radius)),
          child: InkWell(
            onTap: () => onPressedMusic(),
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: Helper.dynamicWidth(context, 5),
                  ),
                  Container(
                    height: Helper.dynamicHeight(context, 4),
                    width: Helper.dynamicHeight(context, 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: R.color.dark_black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Helper.dynamicFont(context, 10),
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      size: Helper.dynamicFont(context, 1.7),
                    ),
                  ),
                  SizedBox(
                    width: Helper.dynamicWidth(context, 3),
                  ),
                  Expanded(
                    child: ButtonTextWidget(
                      text: text,
                      maxLines: 1,
                      fontSize: fontSize,
                      regularFont: regularFont,
                      color: color,
                    ),
                  ),
                  InkWell(
                    onTap: () => onPressedCross(),
                    child: Icon(
                      Icons.cancel_outlined,
                      size: Helper.dynamicFont(context, 1.5),
                    ),
                  ),
                  SizedBox(
                    width: Helper.dynamicWidth(context, 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MusicContainerWithOneIcons extends StatelessWidget {
  final String text;
  final Function onPressedMusic;
  final double radius;
  final double buttonWidth;
  final double buttonHeight;
  final Alignment alignmentBegin;
  final Alignment alignmentEnd;
  final double fontSize;
  final FontWeight fontWeight;

  final bool regularFont;
  final LinearGradient linearGradient;
  final Color color;
  final bool isBoxShadow;

  const MusicContainerWithOneIcons({
    Key? key,
    required this.text,
    required this.onPressedMusic,
    this.radius = 30.0,
    this.buttonWidth = 90,
    this.buttonHeight = 7,
    this.alignmentBegin = Alignment.topCenter,
    this.alignmentEnd = Alignment.bottomCenter,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 1,
    this.regularFont = false,
    this.linearGradient = const LinearGradient(
      colors: [
        Color.fromRGBO(255, 255, 255, 1.0),
        Color.fromRGBO(255, 255, 255, 1.0),
      ],
    ),
    this.color = Colors.black,
    this.isBoxShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.dynamicHeight(context, buttonHeight),
      width: Helper.dynamicWidth(context, buttonWidth),
      decoration: BoxDecoration(
        gradient: linearGradient,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius:
            BorderRadius.circular(Helper.dynamicFont(context, radius)),
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(Helper.dynamicFont(context, radius)),
        child: Material(
          color: Colors.transparent,
          borderRadius:
              BorderRadius.circular(Helper.dynamicFont(context, radius)),
          child: InkWell(
            onTap: () => onPressedMusic(),
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: Helper.dynamicWidth(context, 5),
                  ),
                  Container(
                    height: Helper.dynamicHeight(context, 4),
                    width: Helper.dynamicHeight(context, 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: R.color.dark_black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Helper.dynamicFont(context, 10),
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      size: Helper.dynamicFont(context, 1.7),
                    ),
                  ),
                  SizedBox(
                    width: Helper.dynamicWidth(context, 3),
                  ),
                  Expanded(
                    child: ButtonTextWidget(
                      text: text,
                      maxLines: 1,
                      fontSize: fontSize,
                      regularFont: regularFont,
                      color: color,
                    ),
                  ),
                  SizedBox(
                    width: Helper.dynamicWidth(context, 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
