import 'dart:convert';

class PaymentCard {
  final String name;
  final String cardNumber;
  final String cvv;
  final String expiryDate;

  PaymentCard(
      {required this.cvv,
      required this.name,
      required this.cardNumber,
      required this.expiryDate});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "card_number": cardNumber,
      "cvv": cvv,
      "expiry_date": expiryDate,
    };
  }

  factory PaymentCard.fromMap(Map<String, dynamic> map) {
    return PaymentCard(
      name: map['name'] ?? '',
      cardNumber: map['card_number'] ?? '',
      cvv: map['cvv'] ?? '',
      expiryDate: map['expiry_date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentCard.fromJson(Map<String, dynamic> source) =>
      PaymentCard.fromMap(source);

  PaymentCard copyWith({
    String? name,
    String? cardNumber,
    String? cvv,
    String? expiryDate,
  }) {
    return PaymentCard(
      name: name ?? this.name,
      cardNumber: cardNumber ?? this.cardNumber,
      cvv: cvv ?? this.cvv,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }
}
