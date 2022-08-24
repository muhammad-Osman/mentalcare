import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/provider/user_provider.dart';
import 'package:mentalcaretoday/src/routes/index.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/auth_services.dart';
import '../../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _updateFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  late TextEditingController _dobController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _countryController;
  bool isLoading = false;
  List<File> images = [];
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void updateUser() async {
    setState(() {
      isLoading = true;
    });
    await authService.updateUser(
      context: context,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text.toString(),
      dob: _dobController.text.toString(),
      city: _cityController.text.toString(),
      state: _stateController.text.toString(),
      gender: _radioValue == 0 ? "Male" : "Female",
      country: _countryController.text.toString(),
      email: _emailController.text.toString(),
      images: images,
    );
    setState(() {
      isLoading = false;
    });
  }

  FocusNode emailNode = FocusNode();
  FocusNode firstNnode = FocusNode();
  FocusNode lastNnode = FocusNode();

  FocusNode dobNode = FocusNode();
  FocusNode cityNode = FocusNode();
  FocusNode stateNode = FocusNode();
  FocusNode countryNode = FocusNode();

  DateTime selectedDate = DateTime.now().toLocal();

  int? _radioValue;

  _selectDate(BuildContext context) async {
    print("object");
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
                primary: R.color.buttonColorblue, onSurface: Colors.black),
          ),
          child: child!,
        );
      },

      initialDate: selectedDate.toLocal(), // Refer step 1
      firstDate: DateTime(1800),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('MM-dd-yyyy');
        final String formatted = formatter.format(picked.toLocal());
        _dobController.text = formatted;
      });
    }
  }

  unfocusTextFields() {
    if (emailNode.hasFocus) {
      emailNode.unfocus();
    }

    if (firstNnode.hasFocus) {
      firstNnode.unfocus();
    }
    if (lastNnode.hasFocus) {
      lastNnode.unfocus();
    }
    if (dobNode.hasFocus) {
      dobNode.unfocus();
    }
    if (cityNode.hasFocus) {
      cityNode.unfocus();
    }
    if (stateNode.hasFocus) {
      stateNode.unfocus();
    }
    if (countryNode.hasFocus) {
      countryNode.unfocus();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    _emailController = TextEditingController(text: userProvider.user.email);
    _firstNameController =
        TextEditingController(text: userProvider.user.firstName);
    _lastNameController =
        TextEditingController(text: userProvider.user.lastName);
    _cityController = TextEditingController(text: userProvider.user.city);
    _countryController = TextEditingController(text: userProvider.user.country);
    _dobController = TextEditingController(text: userProvider.user.dob);
    _stateController = TextEditingController(text: userProvider.user.state);
  }

  @override
  void dispose() {
    _emailController.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();

    emailNode.dispose();

    firstNnode.unfocus();

    lastNnode.unfocus();

    dobNode.unfocus();

    cityNode.unfocus();

    stateNode.unfocus();

    countryNode.unfocus();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(
      context,
    );
    int male = userProvider.user.gender == "Male" ? 1 : 0;
    int female = userProvider.user.gender == "Female" ? 1 : 0;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: SingleChildScrollView(
          child: InkWell(
            onTap: () => unfocusTextFields(),
            child: Form(
              key: _updateFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Helper.dynamicHeight(context, 30),
                    width: Helper.dynamicWidth(context, 100),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: Helper.dynamicHeight(context, 0.5),
                          child: SizedBox(
                            width: Helper.dynamicWidth(context, 100),
                            height: Helper.dynamicHeight(context, 45),
                            child: SvgPicture.asset(
                              R.image.curveImage,
                              fit: BoxFit.cover,
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
                            text: "Profile",
                            fontSize: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Positioned(
                          top: Helper.dynamicHeight(context, 12),
                          left: Helper.dynamicWidth(context, 33),
                          child: Container(
                            height: Helper.dynamicWidth(context, 35),
                            width: Helper.dynamicWidth(context, 35),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(244, 252, 255, 1.0),
                              border: Border.all(
                                width: Helper.dynamicFont(context, .5),
                                color: const Color.fromRGBO(244, 252, 255, 1.0),
                              ),
                              borderRadius: BorderRadius.circular(
                                Helper.dynamicFont(context, 15),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Helper.dynamicWidth(context, 0.8),
                              vertical: Helper.dynamicWidth(context, 0.8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Helper.dynamicFont(context, 5),
                              ),
                              child: Image.network(
                                userProvider.user.image == ""
                                    ? "https://cowbotics.alliancetechltd.com/img/default.png"
                                    : userProvider.user.image!,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Padding(
                                    padding: EdgeInsets.all(
                                        Helper.dynamicFont(context, 1.5)),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: Helper.dynamicHeight(context, 25),
                          left: Helper.dynamicWidth(context, 60),
                          child: IconButtonWithGradientBackground(
                            onPressed: () {
                              selectImages();
                            },
                            linearGradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(92, 147, 230, 1.0),
                                Color.fromRGBO(92, 147, 230, 1.0),
                              ],
                            ),
                            buttonHeight: 3.5,
                            buttonWidth: 3.5,
                            imageHeight: 4,
                            imagewidth: 4,
                            icon: Icons.edit,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Helper.dynamicWidth(context, 5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldWithIcon(
                                onChanged: ((p0) {}),
                                controller: _firstNameController,
                                node: firstNnode,
                                placeHolder: "First Name",
                              ),
                            ),
                            SizedBox(
                              width: Helper.dynamicWidth(context, 3),
                            ),
                            Expanded(
                              child: TextFieldWithIcon(
                                onChanged: ((p0) {}),
                                controller: _lastNameController,
                                node: lastNnode,
                                placeHolder: "Last Name",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          onChanged: ((p0) {}),
                          controller: _emailController,
                          node: emailNode,
                          placeHolder: "Email",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        InkWell(
                          onTap: () => _selectDate(context),
                          child: TextFieldWithIcon(
                            onChanged: ((p0) {}),
                            controller: _dobController,
                            node: dobNode,
                            enabledfield: false,
                            placeHolder: "Date of Birth",
                            isSuffixIcon: true,
                            imagePath: R.image.dobIcon,
                            imageHeight: 20,
                            imageWidth: 20,
                          ),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextHeadLine(
                          text: "Gender",
                          fontSize: 1.2,
                          color: R.color.headingTexColor,
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _radioValue ?? male,
                              activeColor: R.color.buttonColorblue,
                              onChanged: (newValue) {
                                setState(() {
                                  _radioValue = newValue as int;
                                });
                              },
                            ),
                            TextWidget(
                              text: "Male",
                              color: R.color.dark_black,
                              fontSize: 1.1,
                            ),
                            Radio(
                              value: 0,
                              groupValue: _radioValue ?? female,
                              activeColor: R.color.buttonColorblue,
                              onChanged: (newValue) {
                                setState(() {
                                  _radioValue = newValue as int;
                                });
                              },
                            ),
                            TextWidget(
                              text: "Female",
                              color: R.color.dark_black,
                              fontSize: 1.1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextHeadLine(
                          text: "Location",
                          fontSize: 1.2,
                          color: R.color.headingTexColor,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          onChanged: ((p0) {}),
                          controller: _cityController,
                          node: cityNode,
                          placeHolder: "city",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          onChanged: ((p0) {}),
                          controller: _stateController,
                          node: stateNode,
                          placeHolder: "state",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          onChanged: ((p0) {}),
                          controller: _countryController,
                          node: countryNode,
                          placeHolder: "country",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        isLoading
                            ? ButtonWithGradientBackground(
                                isLoading: true,
                                text: "SAVE",
                                onPressed: () {},
                              )
                            : ButtonWithGradientBackground(
                                text: "SAVE",
                                onPressed: () {
                                  updateUser();
                                },
                              ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 2),
                        ),
                        ButtonWithGradientBackground(
                          text: "EDIT",
                          color: Colors.black,
                          linearGradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(245, 245, 245, 1.0),
                              Color.fromRGBO(245, 245, 245, 1.0),
                            ],
                          ),
                          onPressed: () {
                            // Navigator.of(context).pushNamed(
                            //   homeScreen,
                            // );
                          },
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
