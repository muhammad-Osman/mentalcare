import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class ConversationListTile extends StatelessWidget {
  const ConversationListTile({
    Key? key,
    this.list,
    required this.index,
    this.verticalPadding = 0.1,
    this.horizontalPadding = 0.5,
    this.containerRadius = 1,
    required this.onPressed,
    this.radius = 40,
    this.buttonWidth = 6.5,
    this.buttonHeight = 6.5,
    this.counterHeigth = 6,
    this.counterWidth = 6,
  }) : super(key: key);

  final List? list;
  final int index;
  final double verticalPadding;
  final double horizontalPadding;
  final double containerRadius;
  final Function onPressed;
  final double radius;
  final double buttonWidth;
  final double buttonHeight;
  final double counterHeigth;
  final double counterWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Helper.dynamicHeight(context, verticalPadding),
        horizontal: Helper.dynamicWidth(context, horizontalPadding),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          Helper.dynamicFont(context, containerRadius),
        ),
        child: InkWell(
          onTap: () => onPressed(),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: Helper.dynamicHeight(context, 2),
              horizontal: Helper.dynamicWidth(context, 4),
            ),
            child: Row(
              children: [
                Stack(
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
                    Positioned(
                      right: Helper.dynamicWidth(context, 4),
                      bottom: Helper.dynamicHeight(context, 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Helper.dynamicFont(context, 5),
                        ),
                        child: Container(
                          height: Helper.dynamicWidth(context, counterHeigth),
                          width: Helper.dynamicWidth(context, counterWidth),
                          color: R.color.paymentbuttonColor,
                          child: Center(
                            child: TextWidget(
                              text: "+1",
                              fontSize: 1,
                              color: R.color.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: Helper.dynamicWidth(context, 5),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: "Isabella Alex",
                            fontSize: 1.25,
                            fontFamily: R.fonts.ralewayMedium,
                            color: R.color.dark_black,
                          ),
                          TextWidget(
                            text: Helper.getFormattedDate(DateTime.now()),
                            fontSize: 0.75,
                            fontFamily: R.fonts.latoRegular,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Helper.dynamicHeight(context, .5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 8,
                            child: TextWidget(
                              text: "Nohting a tonight",
                              fontFamily: R.fonts.ralewayRegular,
                              color: R.color.dark_black,
                              fontSize: 1,
                              maxLines: 2,
                              overFlow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: Helper.dynamicWidth(context, 5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
