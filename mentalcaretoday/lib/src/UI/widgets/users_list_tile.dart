import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class UsersListTile extends StatelessWidget {
  const UsersListTile({
    Key? key,
    this.list,
    required this.index,
    this.verticalPadding = 1,
    this.horizontalPadding = 2,
    this.containerRadius = 1,
    this.imageRadius = 2.5,
    this.radius = 40,
    this.buttonWidth = 6.5,
    this.buttonHeight = 6.5,
    required this.onPressed,
  }) : super(key: key);

  final List? list;
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
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: Colors.black87.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(2, 2),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            Helper.dynamicFont(context, containerRadius),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Helper.dynamicHeight(context, 2),
              horizontal: Helper.dynamicWidth(context, 4),
            ),
            decoration: BoxDecoration(
              color: R.color.userTileColor,
              borderRadius: BorderRadius.circular(
                Helper.dynamicFont(context, containerRadius),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Helper.dynamicHeight(context, buttonHeight),
                  width: Helper.dynamicHeight(context, buttonWidth),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(radius),
                      child: Image.network(
                        "https://www.menshairstyletrends.com/wp-content/uploads/2020/03/boys-shaggy-haircut-_pskphoto--1024x1024.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Helper.dynamicWidth(context, 5),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "Isabella Alex",
                        fontSize: 1.25,
                        color: R.color.dark_black,
                        fontFamily: R.fonts.ralewaySemiBold,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: Helper.dynamicHeight(context, .5),
                      ),
                      TextWidget(
                        text: "27 Yrs",
                        fontSize: 1,
                        fontFamily: R.fonts.latoRegular,
                        color: R.color.dark_black,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: Helper.dynamicHeight(context, .5),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: Helper.dynamicWidth(context, 5),
                        ),
                        child: TextWidget(
                          text:
                              "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has beenthe industry's standard dummy text.",
                          fontSize: 1,
                          color: const Color.fromRGBO(101, 101, 101, 1),
                          maxLines: 3,
                          overFlow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          fontFamily: R.fonts.latoRegular,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => onPressed(),
                  child: SvgPicture.asset(
                    R.image.adduser,
                    width: Helper.dynamicHeight(context, 3),
                    height: Helper.dynamicHeight(context, 3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
