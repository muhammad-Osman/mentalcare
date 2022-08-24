import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class TextFieldWithIcon extends StatelessWidget {
  const TextFieldWithIcon(
      {Key? key,
      this.node,
      this.imagePath,
      this.controller,
      this.imageWidth = 25,
      this.imageHeight = 25,
      this.borderWidth = 5,
      this.placeHolder,
      this.onPressSuffix,
      this.isSecure = false,
      this.enabledfield = true,
      this.isEmail = false,
      this.keyboardType = TextInputType.text,
      this.textInputDecoration = TextInputAction.next,
      this.errorText,
      this.inputFormatters,
      this.fontWeight,
      this.fillColor,
      this.borderColor,
      this.onTap,
      this.textColor,
      this.cursorColor,
      this.placeHolderColor,
      this.isUpdate = false,
      this.maxLines = 1,
      this.minLines = 1,
      this.isSuffixIcon = false,
      this.borderRadius = 15.0,
      required this.onChanged})
      : super(key: key);

  final FocusNode? node;
  final TextEditingController? controller;
  final String? imagePath;
  final bool isUpdate;
  final double imageWidth;
  final double imageHeight;
  final String? placeHolder;
  final Function(String) onChanged;
  final VoidCallback? onPressSuffix;
  final bool isSecure;
  final bool isEmail;
  final double borderRadius;
  final bool enabledfield;
  final TextInputType keyboardType;
  final TextInputAction textInputDecoration;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final FontWeight? fontWeight;
  final Color? fillColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? cursorColor;
  final Color? placeHolderColor;
  final int maxLines;
  final int borderWidth;
  final bool isSuffixIcon;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: node,
      onChanged: onChanged,
      onTap: onTap,
      enabled: enabledfield,
      textCapitalization: TextCapitalization.none,
      obscureText: isSecure,
      obscuringCharacter: "*",
      keyboardType: keyboardType,
      textInputAction: textInputDecoration,
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      cursorColor: cursorColor ?? Colors.black,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        decoration: TextDecoration.none,
        color: textColor ?? R.color.dark_black,
        fontFamily: R.fonts.ralewayRegular,
      ),
      decoration: InputDecoration(
        errorText: errorText,
        errorMaxLines: 3,
        errorStyle: TextStyle(height: 0),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 23, horizontal: 23),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? R.color.headingTexColor,
            width: 1.2,
          ),
        ),
        fillColor: fillColor ?? R.color.textfieldColor,
        filled: true,
        hintText: placeHolder,
        hintStyle: TextStyle(
            color: R.color.hintPlaceHolderColor,
            fontSize: Helper.dynamicFont(context, 1.1)),
        suffixIcon: Visibility(
          visible: isSuffixIcon,
          child: Padding(
            padding: EdgeInsets.only(right: Helper.dynamicWidth(context, 2)),
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressSuffix,
                  child: Padding(
                    padding: EdgeInsets.all(Helper.dynamicFont(context, 0.8)),
                    child: SvgPicture.asset(
                      imagePath.toString(),
                      width: imageWidth,
                      height: imageHeight,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: Helper.dynamicWidth(context, 5),
          minWidth: Helper.dynamicWidth(context, 5),
        ),
      ),
      validator: isEmail
          ? (email) {
              if (email!.isEmpty) {
                return "";
              } else if (!EmailValidator.validate(email)) {
                return "";
              }
              return null;
            }
          : (val) {
              if (val == null || val.isEmpty) {
                return '';
              }
              return null;
            },
    );
  }
}

class SimpleTextField extends StatelessWidget {
  const SimpleTextField(
      {Key? key,
      this.node,
      this.imagePath,
      this.controller,
      this.imageWidth = 25,
      this.imageHeight = 25,
      this.borderWidth = 5,
      this.placeHolder,
      this.onPressSuffix,
      this.isSecure = false,
      this.enabledfield = true,
      this.keyboardType = TextInputType.text,
      this.textInputDecoration = TextInputAction.next,
      this.errorText,
      this.inputFormatters,
      this.fontWeight,
      this.borderColor,
      this.onTap,
      this.textColor,
      this.cursorColor,
      this.placeHolderColor,
      this.maxLines = 1,
      this.minLines = 1,
      this.isSuffixIcon = false,
      this.borderRadius = 15.0})
      : super(key: key);

  final FocusNode? node;
  final TextEditingController? controller;
  final String? imagePath;
  final double imageWidth;
  final double imageHeight;
  final String? placeHolder;
  final VoidCallback? onPressSuffix;
  final bool isSecure;
  final double borderRadius;
  final bool enabledfield;
  final TextInputType keyboardType;
  final TextInputAction textInputDecoration;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final FontWeight? fontWeight;

  final Color? borderColor;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? cursorColor;
  final Color? placeHolderColor;
  final int maxLines;
  final int borderWidth;
  final bool isSuffixIcon;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      focusNode: node,
      onChanged: (a) {},
      onTap: onTap,
      enabled: enabledfield,
      textCapitalization: TextCapitalization.none,
      obscureText: isSecure,
      obscuringCharacter: "*",
      keyboardType: keyboardType,
      textInputAction: textInputDecoration,
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      cursorColor: cursorColor ?? Colors.black,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        decoration: TextDecoration.none,
        color: textColor ?? R.color.dark_black,
        fontFamily: R.fonts.ralewayRegular,
      ),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: R.color.textfieldColor,
            width: 1.0,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        filled: false,
        hintText: placeHolder,
        hintStyle: TextStyle(
            color: R.color.hintPlaceHolderColor,
            fontSize: Helper.dynamicFont(context, 1.1)),
        suffixIcon: Visibility(
          visible: isSuffixIcon,
          child: Padding(
            padding: EdgeInsets.only(right: Helper.dynamicWidth(context, 2)),
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressSuffix,
                  child: Padding(
                    padding: EdgeInsets.all(Helper.dynamicFont(context, 0.8)),
                    child: SvgPicture.asset(
                      imagePath.toString(),
                      width: imageWidth,
                      height: imageHeight,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: Helper.dynamicWidth(context, 5),
          minWidth: Helper.dynamicWidth(context, 5),
        ),
      ),
    );
  }
}

class TextFieldSearchWithIcon extends StatelessWidget {
  const TextFieldSearchWithIcon({
    Key? key,
    this.node,
    required this.imagePath,
    this.controller,
    this.imageWidth = 25,
    this.imageHeight = 25,
    this.placeHolder,
    required this.onPressSuffix,
    this.isSecure = false,
    this.emailSuggestion = false,
    this.enabledfield = true,
    this.keyboardType = TextInputType.text,
    this.textInputDecoration = TextInputAction.next,
    this.errorText,
    this.isErrorBorder = false,
    this.inputFormatters,
    this.fontWeight,
    this.fillColor,
    this.borderColor,
    this.onTap,
    this.textColor,
    this.cursorColor,
    this.placeHolderColor,
    required this.onChange,
    required this.onSubmit,
  }) : super(key: key);

  final FocusNode? node;
  final TextEditingController? controller;
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  final String? placeHolder;
  final VoidCallback onPressSuffix;
  final bool isSecure;
  final bool emailSuggestion;
  final bool enabledfield;
  final TextInputType keyboardType;
  final TextInputAction textInputDecoration;
  final String? errorText;
  final bool isErrorBorder;
  final List<TextInputFormatter>? inputFormatters;
  final FontWeight? fontWeight;
  final Color? fillColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? cursorColor;
  final Color? placeHolderColor;
  final VoidCallback onChange;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: inputFormatters,
      enableSuggestions: emailSuggestion,
      focusNode: node,
      onChanged: (a) => onChange(),
      onTap: onTap,
      enabled: enabledfield,
      textCapitalization: TextCapitalization.none,
      obscureText: isSecure,
      obscuringCharacter: "*",
      keyboardType: keyboardType,
      textInputAction: textInputDecoration,
      controller: controller,
      cursorColor: cursorColor ?? Colors.black,
      onSubmitted: (a) => onSubmit(),
      style: TextStyle(
        fontWeight:
            fontWeight ?? Theme.of(context).textTheme.subtitle1!.fontWeight,
        decoration: TextDecoration.none,
        color: textColor ?? Theme.of(context).textTheme.subtitle2!.color!,
        fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
      ),
      decoration: InputDecoration(
        errorText: errorText,
        errorMaxLines: 3,
        errorStyle: TextStyle(fontSize: Helper.dynamicFont(context, 1.2)),
        errorBorder: isErrorBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .border!
                        .borderSide
                        .color,
                    width: Theme.of(context)
                        .inputDecorationTheme
                        .border!
                        .borderSide
                        .width),
              )
            : null,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(
            color: borderColor ?? const Color.fromRGBO(112, 112, 112, 1),
            width:
                Theme.of(context).inputDecorationTheme.border!.borderSide.width,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(
            color: const Color.fromRGBO(112, 112, 112, 1),
            width:
                Theme.of(context).inputDecorationTheme.border!.borderSide.width,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(
            color: borderColor ??
                Theme.of(context).inputDecorationTheme.border!.borderSide.color,
            width:
                Theme.of(context).inputDecorationTheme.border!.borderSide.width,
          ),
        ),
        fillColor:
            fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
        filled: true,
        hintText: placeHolder,
        hintStyle: TextStyle(
          color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: Helper.dynamicWidth(context, 2)),
          child: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressSuffix,
                child: Padding(
                  padding: EdgeInsets.all(Helper.dynamicFont(context, 0.8)),
                  child: Image.asset(
                    'assets/images/$imagePath.png',
                    width: imageWidth,
                    height: imageHeight,
                  ),
                ),
              ),
            ),
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: Helper.dynamicWidth(context, 5),
          minWidth: Helper.dynamicWidth(context, 5),
        ),
      ),
    );
  }
}

class TextFieldBio extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode node;

  const TextFieldBio({
    required this.controller,
    required this.node,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: node,
      maxLines: 10,
      cursorColor: Colors.black,
      validator: (value) {
        return controller.text.length >= 5
            ? null
            : "Reason must be between 5 to 50 characters";
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      style: TextStyle(
        decoration: TextDecoration.none,
        color: Theme.of(context).textTheme.subtitle2!.color!,
        fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: Helper.dynamicWidth(context, 4),
            top: Helper.dynamicHeight(context, 5),
          ),
          hintText: "Share your thought",
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.subtitle2!.color,
            // fontFamily: 'HelveticaNeueRegular',
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
          ),
          filled: true,
          fillColor: const Color.fromRGBO(255, 241, 247, 1),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
          )),
    );
  }
}
