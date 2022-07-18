import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentalcaretoday/src/UI/views/home_screen.dart';
import 'package:mentalcaretoday/src/provider/payment_provider.dart';
import 'package:mentalcaretoday/src/utils/end_points.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/payment_card.dart';
import '../utils/error_handling.dart';
import '../utils/utils.dart';

class PaymentServices {
  // add Payement Card
  Future addPaymentCard({
    required BuildContext context,
    required final String name,
    required final String cardNumber,
    required final String cvv,
    required final String expiryDate,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    if (token == null) {
      prefs.setString('x-auth-token', '');
    }

    try {
      PaymentCard card = PaymentCard(
          cvv: cvv, name: name, cardNumber: cardNumber, expiryDate: expiryDate);

      http.Response res = await http.post(
        Uri.parse(addCardUrl),
        body: card.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Payment Detail Added Successfuly!',
          );
          Navigator.of(context).pop();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user Card
  Future getUserCardData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse(viewCardUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      // ignore: use_build_context_synchronously
      var paymentProvider =
          Provider.of<PaymentProvider>(context, listen: false);
      final Map<String, dynamic> card = json.decode(userRes.body);
      paymentProvider.setCard(card["card"]);
    } catch (e) {
      print("User Card Not Found");
      // showSnackBar(context, e.toString());
    }
  }
}
