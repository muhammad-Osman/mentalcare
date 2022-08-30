import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/routes/index.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../services/auth_services.dart';
import '../../services/firebase_auth_services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FBServices _fbServices = FBServices();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  bool _isPasswordVisible = true;

  _toggleVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  unfocusTextFields() {
    if (emailNode.hasFocus) {
      emailNode.unfocus();
    }
    if (passwordNode.hasFocus) {
      passwordNode.unfocus();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.unfocus();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;
  void signInUser() async {
    setState(() {
      isLoading = true;
    });
    await authService.signInUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
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
        child: InkWell(
          onTap: () => unfocusTextFields(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _signInFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Helper.dynamicHeight(context, 35),
                    width: Helper.dynamicWidth(context, 100),
                    child: Stack(
                      children: [
                        Positioned(
                          child: SizedBox(
                            width: Helper.dynamicWidth(context, 100),
                            height: Helper.dynamicHeight(context, 35),
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
                          top: Helper.dynamicHeight(context, 14),
                          left: 0,
                          right: 0,
                          child: const AppBarTextHeadLine(text: "Welcome!"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Helper.dynamicWidth(context, 5)),
                    child: TextFieldWithIcon(
                      onChanged: ((p0) {}),
                      controller: emailController,
                      isEmail: true,
                      node: emailNode,
                      placeHolder: "Email address",
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 2.5),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Helper.dynamicWidth(context, 5)),
                    child: TextFieldWithIcon(
                      onChanged: ((p0) {}),
                      controller: passwordController,
                      node: passwordNode,
                      placeHolder: "Password",
                      isSuffixIcon: true,
                      isSecure: _isPasswordVisible,
                      imagePath: _isPasswordVisible
                          ? R.image.inVisible
                          : R.image.isVisible,
                      onPressSuffix: () => _toggleVisibility(),
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 4),
                  ),
                  isLoading
                      ? ButtonWithGradientBackground(
                          isLoading: true,
                          text: "SIGN UP",
                          onPressed: () {},
                        )
                      : ButtonWithGradientBackground(
                          text: "Login",
                          onPressed: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  InkWell(
                    child: TextWidget(
                      text: "Forgot Password?",
                      color: R.color.dark_black,
                      fontSize: 1.1,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        forgotPasswordScreen,
                      );
                    },
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  Image.asset(
                    R.image.divider,
                    height: Helper.dynamicHeight(context, 2.5),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 4),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLoginButton(
                        ontap: () {
                          _fbServices.signInWithGoogle(context);
                        },
                        image: R.image.google,
                      ),
                      SizedBox(
                        width: Helper.dynamicWidth(context, 8),
                      ),
                      SocialLoginButton(
                        ontap: () {},
                        image: R.image.apple,
                      ),
                      SizedBox(
                        width: Helper.dynamicWidth(context, 8),
                      ),
                      SocialLoginButton(
                        ontap: () {},
                        image: R.image.facebook,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 7),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: "DON'T HAVE AN ACCOUNT?",
                        color: R.color.normalTextColor,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(signUpScreen);
                        },
                        child: TextWidget(
                          text: "SIGN UP",
                          color: R.color.buttonColorblue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 2),
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
