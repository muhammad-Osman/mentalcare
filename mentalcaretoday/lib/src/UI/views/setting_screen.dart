import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/account_settings_tile.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/delete_dialog.dart';
import 'package:mentalcaretoday/src/UI/widgets/logout_dialog.dart';
import 'package:mentalcaretoday/src/UI/widgets/more_list_tile.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/routes/index.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../provider/user_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(
      context,
    );
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: Stack(
          children: [
            Positioned(
              bottom: Helper.dynamicHeight(context, 67),
              child: SizedBox(
                width: Helper.dynamicWidth(context, 100),
                height: Helper.dynamicHeight(context, 45),
                child: Center(
                  child: SvgPicture.asset(
                    R.image.curveImage,
                    fit: BoxFit.cover,
                  ),
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
                text: "Settings",
                fontSize: 2,
              ),
            ),
            Positioned(
              top: Helper.dynamicHeight(context, 15),
              bottom: 0,
              child: Center(
                child: Container(
                  height: Helper.dynamicHeight(context, 82),
                  width: Helper.dynamicWidth(context, 100),
                  padding: EdgeInsets.symmetric(
                    horizontal: Helper.dynamicWidth(context, 3),
                  ),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Helper.dynamicWidth(context, 7),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Helper.dynamicFont(context, 13.5)),
                                child: Image.network(
                                  userProvider.user.image == ""
                                      ? "https://cowbotics.alliancetechltd.com/img/default.png"
                                      : userProvider.user.image!,
                                  fit: BoxFit.cover,
                                  // loadingBuilder: (BuildContext context, Widget child,
                                  //     ImageChunkEvent? loadingProgress) {
                                  //   if (loadingProgress == null) return child;
                                  //   return Padding(
                                  //     padding: EdgeInsets.all(Helper.dynamicFont(context, 1.5)),
                                  //     child: SpinKitFadingCube(
                                  //       color: const Color.fromRGBO(248, 45, 75, 1),
                                  //       size: Helper.dynamicFont(context, 3.5),
                                  //     ),
                                  //   );
                                  // },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Padding(
                                      padding: EdgeInsets.all(
                                          Helper.dynamicFont(context, 0.5)),
                                      child: Center(
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade400,
                                          highlightColor: Colors.grey.shade300,
                                          child: Container(
                                            width: Helper.dynamicWidth(
                                                context, 10),
                                            height: Helper.dynamicWidth(
                                                context, 10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  width: Helper.dynamicWidth(context, 10),
                                  height: Helper.dynamicWidth(context, 10),
                                ),
                              ),
                              SizedBox(
                                width: Helper.dynamicWidth(context, 3),
                              ),
                              TextWidget(
                                text: userProvider.user.firstName,
                                color: R.color.dark_black,
                                fontSize: 1.5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 1),
                        ),
                        SizedBox(
                          width: Helper.dynamicWidth(context, 100),
                          child: Divider(
                            color: R.color.hintPlaceHolderColor,
                          ),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Helper.dynamicWidth(context, 7),
                          ),
                          child: TextWidget(
                            text: "Account Settings",
                            color: R.color.normalTextColor,
                            fontSize: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 1),
                        ),
                        AccountSettingsTile(
                          title: "Edit Profile screen",
                          icon: Icons.arrow_forward_ios,
                          onpress: () {
                            Navigator.of(context).pushNamed(profileScreen);
                          },
                        ),
                        AccountSettingsTile(
                          title: "Edit Card Details",
                          icon: Icons.arrow_forward_ios,
                          onpress: () {
                            Navigator.of(context).pushNamed(editCardScreen);
                          },
                        ),
                        AccountSettingsTile(
                          title: "Privacy Policy",
                          icon: Icons.arrow_forward_ios,
                          onpress: () {},
                        ),
                        AccountSettingsTile(
                          title: "Terms & Conditions",
                          icon: Icons.arrow_forward_ios,
                          onpress: () {},
                        ),
                        SizedBox(
                          width: Helper.dynamicWidth(context, 100),
                          child: Divider(
                            color: R.color.hintPlaceHolderColor,
                          ),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Helper.dynamicWidth(context, 7),
                          ),
                          child: TextWidget(
                            text: "More",
                            color: R.color.normalTextColor,
                            fontSize: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 1),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.of(context).pushNamed(feedbackScreen);
                          }),
                          child: MoreListTile(
                            title: "Send Feedback",
                            imagePath: R.image.feedback,
                          ),
                        ),
                        MoreListTile(
                          title: "Cancel Subscription",
                          imagePath: R.image.cancelSub,
                        ),
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return const LogoutDialog();
                                });
                            // _authService.logoutUser(context: context);
                          },
                          child: MoreListTile(
                            title: "Log-out",
                            imagePath: R.image.logout,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return const DeleteDialog();
                                });
                          },
                          child: MoreListTile(
                            title: "Delete Account",
                            imagePath: R.image.deleteAccount,
                          ),
                        ),
                      ],
                    ),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Helper.dynamicFont(context, 0.8),
                      ),
                    ),
                    shadowColor: R.color.textfieldColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
