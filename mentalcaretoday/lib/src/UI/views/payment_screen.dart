import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

import '../../services/payment_services.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _cardFormKey = GlobalKey<FormState>();
  final PaymentServices _paymentServices = PaymentServices();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _creditCardController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  FocusNode cardHolderNode = FocusNode();
  FocusNode creditCardNode = FocusNode();
  FocusNode expirationNode = FocusNode();
  FocusNode cvvNode = FocusNode();

  unfocusTextFields() {
    if (cardHolderNode.hasFocus) {
      cardHolderNode.unfocus();
    }
    if (creditCardNode.hasFocus) {
      creditCardNode.unfocus();
    }
    if (expirationNode.hasFocus) {
      expirationNode.unfocus();
    }
    if (cvvNode.hasFocus) {
      cvvNode.unfocus();
    }
  }

  bool isLoading = false;
  void addCard() async {
    setState(() {
      isLoading = true;
    });
    await _paymentServices.addPaymentCard(
      cardNumber: _creditCardController.text,
      context: context,
      cvv: _cvvController.text,
      name: _cardHolderController.text,
      expiryDate: _expirationController.text,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: InkWell(
            onTap: () => unfocusTextFields(),
            child: Form(
              key: _cardFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Helper.dynamicHeight(context, 125),
                    width: Helper.dynamicWidth(context, 100),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: Helper.dynamicHeight(context, 98),
                          child: SvgPicture.asset(
                            R.image.curveImage,
                            fit: BoxFit.cover,
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
                          ),
                        ),
                        Positioned(
                          top: Helper.dynamicHeight(context, 13),
                          left: Helper.dynamicWidth(context, 9),
                          child: TextHeadLine(
                            text: "Select Subscription Deal",
                            fontSize: 1.3,
                            color: R.color.headingTexColor,
                            textAlign: TextAlign.start,
                            fontFamily: R.fonts.latoRegular,
                          ),
                        ),
                        Positioned(
                          top: Helper.dynamicHeight(context, 17),
                          child: Container(
                            height: Helper.dynamicHeight(context, 45),
                            width: Helper.dynamicWidth(context, 100),
                            padding: EdgeInsets.symmetric(
                              horizontal: Helper.dynamicWidth(context, 8),
                            ),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Helper.dynamicWidth(context, 7),
                                        vertical:
                                            Helper.dynamicHeight(context, 3)),
                                    child: TextWidget(
                                      text: "Basic",
                                      color: R.color.dark_black,
                                      fontSize: 1.8,
                                      fontFamily: R.fonts.ralewayBold,
                                    ),
                                  ),
                                  PaymentCardListTile(
                                    text: "Can record affirmations",
                                    textColor: R.color.headingTexColor,
                                  ),
                                  PaymentCardListTile(
                                    text: "Name recorded affirmations",
                                    textColor: R.color.headingTexColor,
                                  ),
                                  PaymentCardListTile(
                                    text: "Play Affirmation before saving it",
                                    textColor: R.color.headingTexColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Helper.dynamicWidth(context, 20),
                                        vertical:
                                            Helper.dynamicHeight(context, 2)),
                                    child: Row(
                                      children: [
                                        TextWidget(
                                          text: "\$123",
                                          color: R.color.dark_black,
                                          fontSize: 1.8,
                                          fontFamily: R.fonts.latoBold,
                                        ),
                                        TextWidget(
                                          text: " /month",
                                          color: R.color.dark_black,
                                          fontSize: 1.1,
                                          fontFamily: R.fonts.latoRegular,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: ButtonWidget(
                                      onPressed: () {},
                                      text: "Choose",
                                      fontSize: 1.5,
                                      buttonColor: R.color.paymentbuttonColor,
                                      textColor: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Helper.dynamicFont(context, 2),
                                ),
                              ),
                              shadowColor: R.color.textfieldColor,
                            ),
                          ),
                        ),
                        Positioned(
                          top: Helper.dynamicHeight(context, 65),
                          child: Container(
                            height: Helper.dynamicHeight(context, 55),
                            width: Helper.dynamicWidth(context, 100),
                            padding: EdgeInsets.symmetric(
                              horizontal: Helper.dynamicWidth(context, 8),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromRGBO(78, 129, 235, 1.0),
                                  width: Helper.dynamicFont(context, 0.1),
                                ),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(78, 129, 235, 1.0),
                                    Color.fromRGBO(141, 227, 216, 1.0),
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 15,
                                    offset: const Offset(
                                        0, 10), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    Helper.dynamicFont(context, 2)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Helper.dynamicWidth(context, 7),
                                        vertical:
                                            Helper.dynamicHeight(context, 3)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          text: "Premium",
                                          color: R.color.white,
                                          fontSize: 1.8,
                                          fontFamily: R.fonts.ralewayBold,
                                        ),
                                        Container(
                                          height:
                                              Helper.dynamicHeight(context, 3),
                                          width:
                                              Helper.dynamicWidth(context, 20),
                                          decoration: BoxDecoration(
                                            color: R.color.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                Helper.dynamicFont(
                                                    context, 0.4),
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: TextWidget(
                                              text: "Save \$40",
                                              color: R.color.buttonColor,
                                              fontFamily: R.fonts.latoBold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PaymentCardListTile(
                                    text: "Can record affirmations",
                                    textColor: R.color.white,
                                  ),
                                  PaymentCardListTile(
                                    text: "Name recorded affirmations",
                                    textColor: R.color.white,
                                  ),
                                  PaymentCardListTile(
                                    text: "Play Affirmation before saving it",
                                    textColor: R.color.white,
                                  ),
                                  PaymentCardListTile(
                                    text: "Play Affrmations from recorded list",
                                    textColor: R.color.white,
                                  ),
                                  PaymentCardListTile(
                                    text: "Delete Recording",
                                    textColor: R.color.white,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Helper.dynamicWidth(context, 20),
                                        vertical:
                                            Helper.dynamicHeight(context, 2)),
                                    child: Row(
                                      children: [
                                        TextWidget(
                                          text: "\$123",
                                          color: R.color.white,
                                          fontSize: 1.8,
                                          fontFamily: R.fonts.latoBold,
                                        ),
                                        TextWidget(
                                          text: " /month",
                                          color: R.color.white,
                                          fontSize: 1.1,
                                          fontFamily: R.fonts.latoRegular,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: ButtonWidget(
                                      onPressed: () {},
                                      text: "Try 1 Month",
                                      fontSize: 1.5,
                                      buttonColor: Colors.white,
                                      textColor: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Helper.dynamicWidth(context, 5)),
                    child: TextFieldWithIcon(
                      onChanged: ((p0) {}),
                      controller: _cardHolderController,
                      node: cardHolderNode,
                      placeHolder: "Card Holder Name",
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Helper.dynamicWidth(context, 5)),
                    child: TextFieldWithIcon(
                      onChanged: ((p0) {}),
                      controller: _creditCardController,
                      keyboardType: TextInputType.number,
                      node: creditCardNode,
                      placeHolder: "Credit Card Number",
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Helper.dynamicWidth(context, 5)),
                    child: TextFieldWithIcon(
                      onChanged: ((p0) {}),
                      controller: _expirationController,
                      node: expirationNode,
                      placeHolder: "Expiration Date",
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Helper.dynamicWidth(context, 5),
                    ),
                    child: TextFieldWithIcon(
                      onChanged: ((p0) {}),
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      node: cvvNode,
                      placeHolder: "CCV",
                    ),
                  ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 4),
                  ),
                  isLoading
                      ? ButtonWithGradientBackground(
                          isLoading: true,
                          text: "Save",
                          onPressed: () {},
                        )
                      : ButtonWithGradientBackground(
                          text: "SAVE CARD DETAILS",
                          onPressed: () {
                            if (_cardFormKey.currentState!.validate()) {
                              addCard();
                            }
                          },
                        ),
                  SizedBox(
                    height: Helper.dynamicHeight(context, 2),
                  ),
                  ButtonWithGradientBackground(
                    text: "PAY",
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
                    height: Helper.dynamicHeight(context, 3),
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

class PaymentCardListTile extends StatelessWidget {
  final Color textColor;
  final String text;
  const PaymentCardListTile({
    Key? key,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Helper.dynamicWidth(context, 2),
      ),
      child: ListTile(
        leading: Icon(
          Icons.check,
          color: textColor,
          size: Helper.dynamicFont(context, 1.4),
        ),
        dense: true,
        title: TextHeadLine(
          text: text,
          fontSize: 1.25,
          color: textColor,
          fontFamily: R.fonts.ralewayRegular,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
