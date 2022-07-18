import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class SelectableTextWidget extends SelectableText {
  const SelectableTextWidget(String data, {Key? key}) : super(data, key: key);

  SelectableTextWidget.ability({
    Key? key,
    required String text,
    required BuildContext context,
    double fontSize = 2,
    bool? softWrap,
    TextAlign? textAlign = TextAlign.center,
    int? maxLines,
    TextDirection? textDirection = TextDirection.ltr,
    String? fontFamily,
    FontWeight? fontWeight,
    TextBaseline? textBaseline,
    TextDecoration? textDecoration,
    FontStyle? fontStyle,
    double? letterSpacing,
    Color? color = Colors.white,
    TextOverflow? overFlow,
  }) : super(
          text,
          key: key,
          toolbarOptions: const ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
          selectionHeightStyle: BoxHeightStyle.max,
          selectionWidthStyle: BoxWidthStyle.max,
          style: TextStyle(
            color: color,
            fontSize: Helper.dynamicFont(context, fontSize),
            // fontFamily:
            //     fontFamily ?? Theme.of(context).textTheme.bodyText1!.fontFamily,
            fontWeight: fontWeight,
            textBaseline: textBaseline,
            decoration: textDecoration,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
          ),
          textScaleFactor: 1,
          textAlign: textAlign,
          maxLines: maxLines,
          textDirection: textDirection,
        );
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.text,
    this.fontSize = 1.2,
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
    this.color = Colors.grey,
    this.overFlow,
  }) : super(key: key);

  final String text;
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
  final Color? color;
  final TextOverflow? overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: Helper.dynamicFont(context, fontSize),
        fontFamily: fontFamily ?? R.fonts.ralewayRegular,
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
      overflow: overFlow,
    );
  }
}

class ButtonTextWidget extends StatelessWidget {
  const ButtonTextWidget({
    Key? key,
    required this.text,
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
    this.regularFont = false,
    this.color = Colors.white,
  }) : super(key: key);

  final String text;
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
  final bool regularFont;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: Helper.dynamicFont(context, fontSize),
        fontFamily: fontFamily ?? R.fonts.ralewayMedium,
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
      overflow: TextOverflow.ellipsis,
      textDirection: textDirection,
    );
  }
}

class TextHeadLine extends StatelessWidget {
  const TextHeadLine({
    Key? key,
    required this.text,
    this.softWrap,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.textDirection = TextDirection.ltr,
    this.fontFamily,
    this.fontWeight,
    this.textBaseline,
    this.textDecoration,
    this.fontStyle,
    this.fontSize = 2.5,
    this.letterSpacing,
    this.color = Colors.black,
  }) : super(key: key);

  final String text;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDirection? textDirection;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextBaseline? textBaseline;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final double fontSize;
  final double? letterSpacing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: Helper.dynamicFont(context, fontSize),
        fontFamily: fontFamily ?? R.fonts.ralewayMedium,
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
    );
  }
}

class AppBarTextHeadLine extends StatelessWidget {
  const AppBarTextHeadLine({
    Key? key,
    required this.text,
    this.softWrap,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.textDirection = TextDirection.ltr,
    this.fontFamily,
    this.fontWeight,
    this.textBaseline,
    this.textDecoration,
    this.fontStyle,
    this.fontSize = 2.5,
    this.letterSpacing,
    this.color = Colors.black,
  }) : super(key: key);

  final String text;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDirection? textDirection;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextBaseline? textBaseline;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final double fontSize;
  final double? letterSpacing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: Helper.dynamicFont(context, fontSize),
        fontFamily: fontFamily ?? R.fonts.ralewayBold,
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
    );
  }
}

class WalkThroughTextWidget extends StatelessWidget {
  const WalkThroughTextWidget({
    Key? key,
    required this.text,
    this.fontSize = 2,
    this.softWrap,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.textDirection = TextDirection.ltr,
    this.fontFamily = 'MODERNA',
    this.fontWeight,
    this.textBaseline,
    this.textDecoration,
    this.fontStyle,
    this.letterSpacing,
    this.color = Colors.white,
  }) : super(key: key);

  final String text;
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
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: Helper.dynamicFont(context, fontSize),
        // fontFamily:
        //     fontFamily ?? Theme.of(context).textTheme.bodyText1!.fontFamily,
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
    );
  }
}

class SignUpTextWidget extends StatelessWidget {
  const SignUpTextWidget({
    Key? key,
    required this.text,
    this.fontSize = 2,
    this.softWrap,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.textDirection = TextDirection.ltr,
    this.fontFamily = 'MODERNA',
    this.fontWeight,
    this.textBaseline,
    this.textDecoration,
    this.fontStyle,
    this.letterSpacing,
    this.color = Colors.white,
  }) : super(key: key);

  final String text;
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
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: Helper.dynamicFont(context, fontSize),
        fontFamily:
            fontFamily ?? Theme.of(context).textTheme.bodyText1!.fontFamily,
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
    );
  }
}
