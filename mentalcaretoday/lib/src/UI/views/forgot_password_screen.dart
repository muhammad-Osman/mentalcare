import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

import '../../services/auth_services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();

  FocusNode emailNode = FocusNode();
  bool isLoading = false;
  void forgotPassword() async {
    setState(() {
      isLoading = true;
    });
    await authService.forgotPassword(
      context: context,
      email: emailController.text,
    );
    setState(() {
      isLoading = false;
    });
  }

  unfocusTextFields() {
    if (emailNode.hasFocus) {
      emailNode.unfocus();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    emailNode.dispose();
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
          child: InkWell(
            onTap: () => unfocusTextFields(),
            child: Form(
              key: _forgotPasswordFormKey,
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
                            text: "Forgot Password",
                            fontSize: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Helper.dynamicWidth(context, 10)),
                    width: Helper.dynamicWidth(context, 100),
                    child: TextWidget(
                      text:
                          "Oops. It happens to the best of us. Input your email \naddress to fix the issue.",
                      color: R.color.dark_black,
                      fontSize: 1.1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Helper.dynamicWidth(context, 5)),
                    child: TextFieldWithIcon(
                      controller: emailController,
                      node: emailNode,
                      placeHolder: "Email address",
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 40),
                  ),
                  ButtonWithGradientBackground(
                    text: "Submit",
                    onPressed: () {
                      if (_forgotPasswordFormKey.currentState!.validate()) {
                        forgotPassword();
                      }
                    },
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
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
