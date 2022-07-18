import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/provider/payment_provider.dart';
import 'package:mentalcaretoday/src/services/payment_services.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';
import 'package:provider/provider.dart';

class EditCardScreen extends StatefulWidget {
  const EditCardScreen({Key? key}) : super(key: key);

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final paymentCardKey = GlobalKey<FormState>();
  final PaymentServices _paymentServices = PaymentServices();
  late TextEditingController _cardHolderController;

  late TextEditingController _creditCardController;
  late TextEditingController _expirationController;
  late TextEditingController _cvvController;
  bool isLoading = false;
  List<File> images = [];

  void updateCard() async {
    setState(() {
      isLoading = true;
    });
    await _paymentServices.addPaymentCard(
        context: context,
        cardNumber: _creditCardController.text,
        cvv: _cvvController.text,
        name: _cardHolderController.text,
        expiryDate: _expirationController.text);
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
    loadCard();
  }

  void loadCard() {
    var paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    _cardHolderController =
        TextEditingController(text: paymentProvider.card.name);

    _creditCardController =
        TextEditingController(text: paymentProvider.card.cardNumber);
    _cvvController = TextEditingController(text: paymentProvider.card.cvv);

    _expirationController =
        TextEditingController(text: paymentProvider.card.expiryDate);
  }

  @override
  void dispose() {
    _cardHolderController.dispose();

    _creditCardController.dispose();
    _expirationController.dispose();
    _cvvController.dispose();

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
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: SingleChildScrollView(
          child: InkWell(
            onTap: () => unfocusTextFields(),
            child: Form(
              key: paymentCardKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Helper.dynamicHeight(context, 15),
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
                            text: "Payment",
                            fontSize: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
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
                        TextFieldWithIcon(
                          controller: _cardHolderController,
                          node: emailNode,
                          placeHolder: "Email",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          controller: _creditCardController,
                          node: cityNode,
                          placeHolder: "city",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          controller: _expirationController,
                          node: stateNode,
                          placeHolder: "state",
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, 3),
                        ),
                        TextFieldWithIcon(
                          controller: _cvvController,
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
                                  updateCard();
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