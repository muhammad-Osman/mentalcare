import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class AccountSettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onpress;
  const AccountSettingsTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Helper.dynamicWidth(context, 3.5),
      ),
      child: ListTile(
        dense: true,
        onTap: () => onpress(),
        leading: TextHeadLine(
          text: title,
          fontSize: 1.3,
          color: R.color.headingTexColor,
          textAlign: TextAlign.start,
        ),
        trailing: Icon(
          icon,
          color: R.color.headingTexColor,
          size: Helper.dynamicFont(context, 1.3),
        ),
      ),
    );
  }
}
