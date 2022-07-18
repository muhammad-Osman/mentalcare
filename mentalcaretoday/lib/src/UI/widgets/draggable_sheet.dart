import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class CustomDraggableScrollableSheet extends StatelessWidget {
  final Widget child;
  final double maxChildSize;
  final double minChildSize;
  final double initialChildSize;

  const CustomDraggableScrollableSheet({
    required this.child,
    this.maxChildSize = 0.6,
    this.minChildSize = 0.6,
    this.initialChildSize = 0.6,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: maxChildSize,
      minChildSize: minChildSize,
      initialChildSize: initialChildSize,
      expand: false,
      builder: (_, controller) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Helper.dynamicWidth(context, 5)),
            topRight: Radius.circular(Helper.dynamicWidth(context, 5)),
          ),
          child: Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Helper.dynamicWidth(context, 5)),
              topRight: Radius.circular(Helper.dynamicWidth(context, 5)),
            ),
            color: Colors.transparent,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: R.color.white,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
