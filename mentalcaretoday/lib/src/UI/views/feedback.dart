import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/provider/payment_provider.dart';
import 'package:mentalcaretoday/src/services/payment_services.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';
import 'package:provider/provider.dart';

import '../../services/feedback_servcies.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final feedbackFromKey = GlobalKey<FormState>();
  final FeedBackServices _feedBackServices = FeedBackServices();
  final TextEditingController _feedBackController = TextEditingController();

  bool isLoading = false;

  void addFeedback() async {
    setState(() {
      isLoading = true;
    });
    _feedBackServices.addFeedback(
        context: context, message: _feedBackController.text);
    setState(() {
      isLoading = false;
    });
  }

  FocusNode emailNode = FocusNode();
  FocusNode firstNnode = FocusNode();
  FocusNode lastNnode = FocusNode();

  FocusNode dobNode = FocusNode();
  FocusNode cityNode = FocusNode();
  FocusNode stateNode = FocusNode();
  FocusNode countryNode = FocusNode();

  unfocusTextFields() {
    if (emailNode.hasFocus) {
      emailNode.unfocus();
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
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _feedBackController.dispose();

    emailNode.dispose();

    firstNnode.unfocus();

    lastNnode.unfocus();

    dobNode.unfocus();

    cityNode.unfocus();

    stateNode.unfocus();

    countryNode.unfocus();

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
              key: feedbackFromKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Helper.dynamicHeight(context, 15),
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
                          left: Helper.dynamicWidth(context, 40),
                          child: const AppBarTextHeadLine(
                            text: "Feedback",
                            fontSize: 2,
                            textAlign: TextAlign.center,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          maxLines: 4,
                          controller: _feedBackController,
                          node: emailNode,
                          placeHolder: "Feedback",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        isLoading
                            ? ButtonWithGradientBackground(
                                isLoading: true,
                                text: "send",
                                onPressed: () {},
                              )
                            : ButtonWithGradientBackground(
                                text: "Send",
                                onPressed: () {
                                  if (feedbackFromKey.currentState!
                                      .validate()) {
                                    addFeedback();
                                  }
                                },
                              ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 4),
                        ),
                      ],
                    ),
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
