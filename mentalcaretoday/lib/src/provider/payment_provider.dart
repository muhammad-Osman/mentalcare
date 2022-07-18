import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/models/payment_card.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentCard _card =
      PaymentCard(cvv: "", name: "", cardNumber: "", expiryDate: "");

  PaymentCard get card => _card;

  void setCard(Map<String, dynamic> card) {
    _card = PaymentCard.fromJson(card);
    notifyListeners();
  }

  void setCardFromModel(PaymentCard card) {
    _card = card;
    notifyListeners();
  }
}
