import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/routes/index.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../services/auth_services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode firstNnode = FocusNode();
  FocusNode lastNnode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode conifrmPassNode = FocusNode();
  FocusNode dobNode = FocusNode();
  FocusNode cityNode = FocusNode();
  FocusNode stateNode = FocusNode();
  FocusNode countryNode = FocusNode();

  DateTime selectedDate = DateTime.now().toLocal();

  bool _checkboxTandPListTile = false;
  bool _checkboxRememberMeListTile = false;
  int? _radioValue;

  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  _toggleCPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
                primary: R.color.buttonColorblue, onSurface: Colors.black),
          ),
          child: child!,
        );
      },

      initialDate: selectedDate.toLocal(), // Refer step 1
      firstDate: DateTime(1800),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final String formatted = formatter.format(picked.toLocal());
        _dobController.text = formatted;
      });
    }
  }

  unfocusTextFields() {
    if (emailNode.hasFocus) {
      emailNode.unfocus();
    }
    if (passwordNode.hasFocus) {
      passwordNode.unfocus();
    }
    if (conifrmPassNode.hasFocus) {
      conifrmPassNode.unfocus();
    }
    if (firstNnode.hasFocus) {
      firstNnode.unfocus();
    }
    if (lastNnode.hasFocus) {
      lastNnode.unfocus();
    }
    if (dobNode.hasFocus) {
      dobNode.unfocus();
    }
    if (cityNode.hasFocus) {
      cityNode.unfocus();
    }
    if (stateNode.hasFocus) {
      stateNode.unfocus();
    }
    if (countryNode.hasFocus) {
      countryNode.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _confirmPasswordController.dispose();
    emailNode.dispose();

    passwordNode.unfocus();

    conifrmPassNode.unfocus();

    firstNnode.unfocus();

    lastNnode.unfocus();

    dobNode.unfocus();

    cityNode.unfocus();

    stateNode.unfocus();

    countryNode.unfocus();

    super.dispose();
  }

  late ProgressDialog pr;
  bool isLoading = false;
  void signUpUser() async {
    setState(() {
      isLoading = true;
    });

    await authService.signUpUser(
      context: context,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      dob: _dobController.text,
      city: _cityController.text,
      state: _stateController.text,
      gender: _radioValue == 0 ? "Male" : "Female",
      country: _countryController.text,
      email: _emailController.text,
      password: _passwordController.text,
      passwordConfirmation: _confirmPasswordController.text,
    );
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: SingleChildScrollView(
          child: InkWell(
            onTap: () => unfocusTextFields(),
            child: Column(
              children: [
                SizedBox(
                  height: Helper.dynamicHeight(context, 30),
                  width: Helper.dynamicWidth(context, 100),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: Helper.dynamicHeight(context, 0.5),
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
                        top: Helper.dynamicHeight(context, 5),
                        left: Helper.dynamicWidth(context, 3),
                        child: BackArrowButton(
                          ontap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Positioned(
                        top: Helper.dynamicHeight(context, 6),
                        left: Helper.dynamicWidth(context, 25),
                        child: const AppBarTextHeadLine(
                          text: "Create Account!",
                          fontSize: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Helper.dynamicWidth(context, 5),
                  ),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldWithIcon(
                                onChanged: ((p0) {}),
                                controller: _firstNameController,
                                node: firstNnode,
                                placeHolder: "First Name",
                              ),
                            ),
                            SizedBox(
                              width: Helper.dynamicWidth(context, 3),
                            ),
                            Expanded(
                              child: TextFieldWithIcon(
                                onChanged: ((p0) {}),
                                controller: _lastNameController,
                                node: lastNnode,
                                placeHolder: "Last Name",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          onChanged: ((p0) {}),
                          controller: _emailController,
                          node: emailNode,
                          isEmail: true,
                          placeHolder: "Email address",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          onChanged: ((p0) {}),
                          controller: _passwordController,
                          node: passwordNode,
                          placeHolder: "Password",
                          isSuffixIcon: true,
                          isSecure: _isPasswordVisible,
                          imagePath: _isPasswordVisible
                              ? R.image.inVisible
                              : R.image.isVisible,
                          onPressSuffix: () => _togglePasswordVisibility(),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          onChanged: ((p0) {}),
                          controller: _confirmPasswordController,
                          node: conifrmPassNode,
                          placeHolder: "Confirm Password",
                          isSuffixIcon: true,
                          isSecure: _isConfirmPasswordVisible,
                          imagePath: _isConfirmPasswordVisible
                              ? R.image.inVisible
                              : R.image.isVisible,
                          onPressSuffix: () => _toggleCPasswordVisibility(),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        InkWell(
                          onTap: () => _selectDate(context),
                          child: TextFieldWithIcon(
                            onChanged: ((p0) {}),
                            controller: _dobController,
                            node: dobNode,
                            enabledfield: false,
                            placeHolder: "Date of Birth",
                            isSuffixIcon: true,
                            imagePath: R.image.dobIcon,
                            imageHeight: 20,
                            imageWidth: 20,
                          ),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextHeadLine(
                          text: "Gender",
                          fontSize: 1.2,
                          color: R.color.headingTexColor,
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: _radioValue,
                              activeColor: R.color.buttonColorblue,
                              onChanged: (newValue) {
                                setState(() {
                                  _radioValue = newValue as int;
                                });
                              },
                            ),
                            TextWidget(
                              text: "Male",
                              color: R.color.dark_black,
                              fontSize: 1.1,
                            ),
                            Radio(
                              value: 1,
                              groupValue: _radioValue,
                              activeColor: R.color.buttonColorblue,
                              onChanged: (newValue) {
                                setState(() {
                                  _radioValue = newValue as int;
                                });
                              },
                            ),
                            TextWidget(
                              text: "Female",
                              color: R.color.dark_black,
                              fontSize: 1.1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextHeadLine(
                          text: "Location",
                          fontSize: 1.2,
                          color: R.color.headingTexColor,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          onChanged: ((p0) {}),
                          controller: _cityController,
                          node: cityNode,
                          placeHolder: "City",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          onChanged: ((p0) {}),
                          controller: _stateController,
                          node: stateNode,
                          placeHolder: "State",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          onChanged: ((p0) {}),
                          controller: _countryController,
                          node: countryNode,
                          placeHolder: "Country",
                        ),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: TextWidget(
                            text: "Remember me",
                            color: R.color.dark_black,
                            fontSize: 1.0,
                            textAlign: TextAlign.start,
                          ),
                          value: _checkboxRememberMeListTile,
                          activeColor: R.color.buttonColorblue,
                          onChanged: (value) {
                            setState(() {
                              _checkboxRememberMeListTile =
                                  !_checkboxRememberMeListTile;
                            });
                          },
                        ),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: TextWidget(
                            text:
                                "I agree with the Terms Condition & Privacy Policy",
                            color: R.color.dark_black,
                            fontSize: 1.0,
                            textAlign: TextAlign.start,
                          ),
                          value: _checkboxTandPListTile,
                          activeColor: R.color.buttonColorblue,
                          onChanged: (value) {
                            setState(() {
                              _checkboxTandPListTile = !_checkboxTandPListTile;
                            });
                          },
                        ),
                        isLoading
                            ? ButtonWithGradientBackground(
                                isLoading: true,
                                text: "SIGN UP",
                                onPressed: () {},
                              )
                            : ButtonWithGradientBackground(
                                text: "SIGN UP",
                                onPressed: () {
                                  if (_checkboxTandPListTile == true) {
                                    if (_signUpFormKey.currentState!
                                        .validate()) {
                                      signUpUser();
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please Accept Term and Condition!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }

                                  // Navigator.of(context).pushNamed(
                                  //   homeScreen,
                                  // );
                                },
                              ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 2),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: "ALREADY HAVE AN ACCOUNT?",
                              color: R.color.normalTextColor,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  signInScreen,
                                );
                              },
                              child: TextWidget(
                                text: "SIGN IN",
                                color: R.color.buttonColorblue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Helper.dynamicHeight(context, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
