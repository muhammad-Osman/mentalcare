import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/routes/index.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';

import '../../utils/helper_method.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: Helper.dynamicHeight(context, 68),
              width: Helper.dynamicWidth(context, 100),
              child: Image.asset(
                R.image.splash1,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
            ),
            TextHeadLine(
              text: "Mental Care Today",
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
              height: Helper.dynamicHeight(context, 7),
            ),
            ButtonWithGradientBackground(
                text: "GET STARTED",
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    createdAtScreen,
                  );
                })
          ],
        ),
      ),
    );
  }
}
