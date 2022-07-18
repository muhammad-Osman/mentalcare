import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';
import 'text.dart';

class ButtonWidget extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double? elevation;
  final double radius;
  final double buttonWidth;
  final double buttonHeight;
  final double fontSize;
  final FontWeight fontWeight;
  final Color buttonColor;
  final Color textColor;

  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    this.elevation = 2,
    this.radius = 7.0,
    this.buttonWidth = 50,
    this.buttonHeight = 6,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 1,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Helper.dynamicHeight(context, buttonHeight),
      width: Helper.dynamicWidth(context, buttonWidth),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Helper.dynamicFont(context, .7)),
            ),
          ),
        ),
        child: ButtonTextWidget(
          text: text,
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class ButtonWithGradientBackground extends StatelessWidget {
  final String text;
  final Function onPressed;
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
  final bool isLoading;
  const ButtonWithGradientBackground({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.radius = 30.0,
    this.buttonWidth = 90,
    this.buttonHeight = 7.5,
    this.alignmentBegin = Alignment.topCenter,
    this.alignmentEnd = Alignment.bottomCenter,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 1,
    this.regularFont = false,
    this.linearGradient = const LinearGradient(
      colors: [
        Color.fromRGBO(141, 227, 216, 1.0),
        Color.fromRGBO(126, 194, 220, 1.0),
      ],
    ),
    this.color = Colors.white,
    this.isBoxShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.dynamicHeight(context, buttonHeight),
      width: Helper.dynamicWidth(context, buttonWidth),
      decoration: BoxDecoration(
        boxShadow: isBoxShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]
            : null,
        gradient: linearGradient,
        border: Border.all(
          color: Colors.transparent,
          width: 0,
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
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : InkWell(
                  onTap: () => onPressed(),
                  child: Center(
                    child: ButtonTextWidget(
                      text: text,
                      fontSize: fontSize,
                      regularFont: regularFont,
                      color: color,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class ButtonWithGradientBackgroundAndIcons extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double radius;
  final double buttonWidth;
  final double buttonHeight;
  final Alignment alignmentBegin;
  final Alignment alignmentEnd;
  final double fontSize;
  final FontWeight fontWeight;
  final String imagePath;
  final bool regularFont;
  final LinearGradient linearGradient;
  final Color color;
  final bool isBoxShadow;
  final double imageHeight;
  final double imagewidth;

  const ButtonWithGradientBackgroundAndIcons({
    Key? key,
    required this.text,
    required this.onPressed,
    this.radius = 30.0,
    this.buttonWidth = 90,
    this.buttonHeight = 7.5,
    this.alignmentBegin = Alignment.topCenter,
    this.alignmentEnd = Alignment.bottomCenter,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 1,
    this.regularFont = false,
    required this.imagePath,
    this.linearGradient = const LinearGradient(
      colors: [
        Color.fromRGBO(141, 227, 216, 1.0),
        Color.fromRGBO(126, 194, 220, 1.0),
      ],
    ),
    this.color = Colors.white,
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
        boxShadow: isBoxShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]
            : null,
        gradient: linearGradient,
        border: Border.all(
          color: Colors.transparent,
          width: 0,
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
            onTap: () => onPressed(),
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: Helper.dynamicWidth(context, 5),
                  ),
                  SvgPicture.asset(
                    imagePath.toString(),
                    width: Helper.dynamicHeight(context, imagewidth),
                    height: Helper.dynamicHeight(context, imageHeight),
                  ),
                  SizedBox(
                    width: Helper.dynamicWidth(context, 3),
                  ),
                  ButtonTextWidget(
                    text: text,
                    fontSize: fontSize,
                    regularFont: regularFont,
                    color: color,
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

class ButtonWithGradientBackgroundAndMultiIcons extends StatelessWidget {
  final String text;
  final Function onPressed;
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

  const ButtonWithGradientBackgroundAndMultiIcons({
    Key? key,
    required this.text,
    required this.onPressed,
    this.radius = 30.0,
    this.buttonWidth = 90,
    this.buttonHeight = 7.5,
    this.alignmentBegin = Alignment.topCenter,
    this.alignmentEnd = Alignment.bottomCenter,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 1,
    this.regularFont = false,
    this.linearGradient = const LinearGradient(
      colors: [
        Color.fromRGBO(141, 227, 216, 1.0),
        Color.fromRGBO(126, 194, 220, 1.0),
      ],
    ),
    this.color = Colors.white,
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
          color: Colors.transparent,
          width: 0,
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
            onTap: () => onPressed(),
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
                  // SvgPicture.asset(
                  //   imagePath.toString(),
                  //   width: Helper.dynamicHeight(context, imagewidth),
                  //   height: Helper.dynamicHeight(context, imageHeight),
                  // ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    size: Helper.dynamicFont(context, 3),
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

class IconButtonWithGradientBackground extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final double radius;
  final Alignment alignmentBegin;
  final Alignment alignmentEnd;
  final double buttonWidth;
  final double buttonHeight;

  final LinearGradient? linearGradient;
  final String? imagePath;
  final double imageHeight;
  final double imagewidth;
  const IconButtonWithGradientBackground({
    Key? key,
    required this.onPressed,
    this.icon = Icons.ac_unit,
    this.iconColor = Colors.white,
    this.iconSize = 2,
    this.radius = 40,
    this.alignmentBegin = Alignment.topCenter,
    this.alignmentEnd = Alignment.bottomCenter,
    this.buttonWidth = 6,
    this.buttonHeight = 6,
    this.linearGradient,
    this.imagePath,
    this.imageHeight = 5.0,
    this.imagewidth = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.dynamicHeight(context, buttonHeight),
      width: Helper.dynamicHeight(context, buttonWidth),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     blurRadius: 4,
        //     offset: const Offset(0, 3), // changes position of shadow
        //   ),
        // ],
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(141, 227, 216, 1.0),
            Color.fromRGBO(126, 194, 220, 1.0),
          ],
        ),
        border: Border.all(
          color: Colors.transparent,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          child: InkWell(
            onTap: () => onPressed(),
            child: Center(
              child: imagePath == null
                  ? Icon(
                      icon,
                      color: iconColor,
                      size: Helper.dynamicFont(context, iconSize),
                    )
                  : Image.asset(
                      imagePath!,
                      height: Helper.dynamicWidth(context, imageHeight),
                      width: Helper.dynamicWidth(context, imagewidth),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextUnderLinedButton extends StatelessWidget {
  const TextUnderLinedButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.white,
    this.fontSize = 2,
    this.softWrap,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.textDirection = TextDirection.ltr,
    this.fontFamily,
    this.fontWeight,
    this.textBaseline,
    this.textDecoration,
    this.fontStyle,
    this.letterSpacing,
  }) : super(key: key);

  final String text;
  final Function onTap;
  final Color color;
  final double fontSize;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDirection? textDirection;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextBaseline? textBaseline;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: Helper.dynamicFont(context, fontSize),
          fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
          fontWeight: fontWeight,
          textBaseline: textBaseline,
          decoration: textDecoration,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
        ),
        textScaleFactor: 1,
        textAlign: textAlign,
        softWrap: softWrap,
        maxLines: maxLines,
        textDirection: textDirection,
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final VoidCallback ontap;
  final String image;
  const SocialLoginButton({
    Key? key,
    required this.image,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: InkWell(
        child: SvgPicture.asset(image),
        onTap: () => ontap(),
      ),
    );
  }
}

class BackArrowButton extends StatelessWidget {
  final Function ontap;
  final Color iconColor;
  final Color borderColor;
  const BackArrowButton({
    Key? key,
    this.borderColor = const Color(0xFFA1A4B2),
    this.iconColor = Colors.black,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.dynamicHeight(context, 6),
      width: Helper.dynamicHeight(context, 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            Helper.dynamicFont(context, 10),
          ),
        ),
      ),
      child: InkWell(
          onTap: () => ontap(),
          child: Icon(
            Icons.arrow_back,
            color: iconColor,
          )),
    );
  }
}

class PlayButton extends StatelessWidget {
  final Function ontap;
  final Color iconColor;
  final Color borderColor;
  final IconData icon;
  const PlayButton({
    Key? key,
    required this.icon,
    this.borderColor = const Color(0xFFA1A4B2),
    this.iconColor = Colors.black,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.dynamicHeight(context, 8),
      width: Helper.dynamicHeight(context, 8),
      decoration: BoxDecoration(
        color: R.color.white,
        border: Border.all(
          width: Helper.dynamicFont(context, .6),
          color: R.color.buttonColorblue.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            Helper.dynamicFont(context, 10),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          Helper.dynamicFont(context, 5),
        ),
        child: InkWell(
            onTap: () => ontap(),
            child: Icon(
              icon,
              size: Helper.dynamicFont(context, 2.7),
              color: iconColor,
            )),
      ),
    );
  }
}
