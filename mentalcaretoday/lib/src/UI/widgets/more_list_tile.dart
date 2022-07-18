
import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class MoreListTile extends StatelessWidget {
  final String title;
  final String imagePath;
  const MoreListTile({Key? key, required this.imagePath, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Helper.dynamicWidth(context, 2.5),
      ),
      child: ListTile(
        leading: Container(
          height: Helper.dynamicHeight(context, 5),
          width: Helper.dynamicHeight(context, 5),
          decoration: BoxDecoration(
            color: R.color.textfieldColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                Helper.dynamicFont(context, 10),
              ),
            ),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              height: Helper.dynamicHeight(context, 2.5),
              width: Helper.dynamicHeight(context, 2.5),
            ),
          ),
        ),
        dense: true,
        title: TextHeadLine(
          text: title,
          fontSize: 1.3,
          color: R.color.headingTexColor,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}