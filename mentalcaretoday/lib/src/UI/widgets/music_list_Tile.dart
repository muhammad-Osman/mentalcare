import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/models/single_mood.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class MusicListtTile extends StatelessWidget {
  const MusicListtTile({
    Key? key,
    this.list,
    this.recordings,
    required this.index,
    this.verticalPadding = 0.5,
    this.horizontalPadding = 2,
    this.containerRadius = 1,
    this.imageRadius = 2.5,
    this.radius = 40,
    this.buttonWidth = 6.5,
    this.buttonHeight = 6.5,
    required this.onPressed,
  }) : super(key: key);

  final List<Music>? list;
  final List<Recording>? recordings;

  final int index;
  final double verticalPadding;
  final double horizontalPadding;
  final double containerRadius;
  final double imageRadius;
  final Function onPressed;
  final double radius;
  final double buttonWidth;
  final double buttonHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Helper.dynamicHeight(context, verticalPadding),
        horizontal: Helper.dynamicWidth(context, horizontalPadding),
      ),
      child: Card(
        child: ListTile(
          onTap: () => onPressed(),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: Helper.dynamicFont(context, 0.1),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Helper.dynamicHeight(context, 5),
                width: Helper.dynamicHeight(context, 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: R.color.dark_black,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Helper.dynamicFont(context, 10),
                    ),
                  ),
                ),
                child: const Icon(Icons.play_arrow),
              ),
              SizedBox(
                width: Helper.dynamicWidth(context, 5),
              ),
              SizedBox(
                width: Helper.dynamicWidth(context, 60),
                child: TextWidget(
                  text: list![index].title!,
                  fontSize: 1.25,
                  overFlow: TextOverflow.ellipsis,
                  color: R.color.dark_black,
                  fontFamily: R.fonts.ralewaySemiBold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          trailing: TextWidget(
            text: list![index].createdAt!.toString().substring(0, 11),
            fontSize: 0.75,
            fontFamily: R.fonts.latoRegular,
          ),
        ),
      ),
    );
  }
}
