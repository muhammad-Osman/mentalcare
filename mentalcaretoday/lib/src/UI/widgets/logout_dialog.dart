import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../services/auth_services.dart';
import '../../utils/constants.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  final AuthService _authService = AuthService();
  late ProgressDialog pr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = ProgressDialog(context);
  }

  void logout() async {
    pr.style(
        elevation: 10,
        insetAnimCurve: Curves.easeInOut,
        backgroundColor: const Color.fromRGBO(126, 194, 220, 1.0),
        message: "Please wait!",
        messageTextStyle: const TextStyle(color: Colors.white, fontSize: 13),
        progressWidget: const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        )));
    pr = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: true, showLogs: true);

    await pr.show();
    _authService.logoutUser(context: context);
    await Future.delayed(const Duration(seconds: 3));
    pr.hide();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: screenWidth * 0.65,
          height: screenHeight * 0.15,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(141, 227, 216, 1.0),
                Color.fromRGBO(126, 194, 220, 1.0),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: 'Are you sure to logout ?',
                color: R.color.white,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (() {
                      Navigator.of(context).pop();
                    }),
                    child: TextWidget(
                      text: 'Cancel',
                      color: R.color.white,
                      fontSize: 1,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: (() {
                      logout();
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextWidget(
                          text: 'Logout',
                          fontSize: 1,
                          color: R.color.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
