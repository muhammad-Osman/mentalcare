import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/routes/index.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class CreatedAtScreen extends StatefulWidget {
  const CreatedAtScreen({Key? key}) : super(key: key);

  @override
  State<CreatedAtScreen> createState() => _CreatedAtScreenState();
}

class _CreatedAtScreenState extends State<CreatedAtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: Column(
          children: [
            SizedBox(
              height: Helper.dynamicHeight(context, 68),
              width: Helper.dynamicWidth(context, 100),
              child: Image.asset(
                R.image.createdAt,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
            ),
            TextHeadLine(
              text: "We are what we do",
              color: R.color.headingTexColor,
            ),
            SizedBox(
              height: Helper.dynamicHeight(context, 2.5),
            ),
            TextWidget(
              text:
                  "Thousand of people are using mental care app to play frequencies based on their mood",
              color: R.color.normalTextColor,
            ),
            SizedBox(
              height: Helper.dynamicHeight(context, 4),
            ),
            ButtonWithGradientBackground(
              text: "SIGN UP",
              onPressed: () {
                Navigator.of(context).pushNamed(
                  signUpScreen,
                );
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
    );
  }
}
