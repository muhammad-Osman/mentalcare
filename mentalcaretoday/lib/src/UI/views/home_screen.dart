import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/routes/index.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

import '../../models/mood.dart';
import '../../services/mood_services.dart';
import '../../services/payment_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _radioValue;
  final PaymentServices _paymentServices = PaymentServices();
  final MoodServices _moodServices = MoodServices();
  Mood? moodsList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentServices.getUserCardData(context);
    fetchMoods();
  }

  bool isLoading = false;
  void fetchMoods() async {
    setState(() {
      isLoading = true;
    });
    moodsList = await _moodServices.getMoods(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Helper.dynamicHeight(context, 35),
                width: Helper.dynamicWidth(context, 100),
                child: Stack(
                  children: [
                    Positioned(
                      child: SizedBox(
                        width: Helper.dynamicWidth(context, 100),
                        height: Helper.dynamicHeight(context, 35),
                        child: Image.asset(
                          R.image.welcome,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: Helper.dynamicHeight(context, 5),
                      left: Helper.dynamicWidth(context, 10),
                      right: Helper.dynamicWidth(context, 10),
                      child: AppBarTextHeadLine(
                        text: "Welcome!",
                        fontFamily: R.fonts.ralewaySemiBold,
                        color: R.color.white,
                        fontSize: 1.9,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Positioned(
                      top: Helper.dynamicHeight(context, 9),
                      left: Helper.dynamicWidth(context, 11),
                      right: Helper.dynamicWidth(context, 11),
                      child: TextHeadLine(
                        text: "How are you today?",
                        color: R.color.white,
                        fontSize: 1.3,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: Helper.dynamicWidth(context, 77),
                        height: Helper.dynamicHeight(context, 35),
                        child: SvgPicture.asset(
                          R.image.waves,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Helper.dynamicHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Helper.dynamicWidth(context, 6)),
                child: const TextHeadLine(
                  text: "Choose One to continue with ",
                  fontSize: 1.3,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                  width: Helper.dynamicWidth(context, 100),
                  height: isLoading ? 100 : 195,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: moodsList!.moods!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Helper.dynamicWidth(context, 1),
                                    ),
                                    child: Radio(
                                      value: index,
                                      groupValue: _radioValue,
                                      activeColor: R.color.buttonColorblue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _radioValue = newValue as int;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: index / 2 == 0
                                            ? const AssetImage(
                                                "assets/images/sad.png")
                                            : const AssetImage(
                                                "assets/images/sad.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: AppBarTextHeadLine(
                                        text: moodsList!.moods![index].name!,
                                        fontFamily: R.fonts.ralewaySemiBold,
                                        color: R.color.white,
                                        fontSize: 1.1,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Helper.dynamicWidth(context, 6)),
                child: const TextHeadLine(
                  text: "Perform action",
                  fontSize: 1.3,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: Helper.dynamicHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Helper.dynamicWidth(context, 6)),
                child: ButtonWithGradientBackgroundAndIcons(
                  text: "GO",
                  fontSize: 1.2,
                  imagePath: R.image.fwdArrow,
                  linearGradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(141, 227, 216, 1.0),
                      Color.fromRGBO(126, 194, 220, 1.0),
                    ],
                  ),
                  onPressed: () {
                    if (_radioValue == null) {
                      Fluttertoast.showToast(
                          msg: "Please Select Mood",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    } else {
                      Navigator.of(context).pushNamed(musicListScreen,
                          arguments: moodsList!.moods![_radioValue!].id);
                    }
                  },
                ),
              ),
              SizedBox(
                height: Helper.dynamicHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Helper.dynamicWidth(context, 6)),
                child: ButtonWithGradientBackgroundAndIcons(
                  text: "SUBSCRIBE",
                  fontSize: 1.2,
                  imageHeight: 2.5,
                  imagewidth: 2.5,
                  imagePath: R.image.subscribe,
                  color: R.color.dark_black,
                  linearGradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(235, 234, 236, 1.0),
                      Color.fromRGBO(235, 234, 236, 1.0),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(paymentScreen);
                  },
                ),
              ),
              SizedBox(
                height: Helper.dynamicHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Helper.dynamicWidth(context, 6)),
                child: ButtonWithGradientBackgroundAndIcons(
                  text: "SETTINGS",
                  color: R.color.dark_black,
                  fontSize: 1.2,
                  imagePath: R.image.setting,
                  linearGradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1.0),
                      Color.fromRGBO(255, 255, 255, 1.0),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(settingScreen);
                  },
                ),
              ),
              SizedBox(
                height: Helper.dynamicHeight(context, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
