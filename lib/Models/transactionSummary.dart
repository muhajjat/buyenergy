import 'package:flutter/foundation.dart';

class TransactionSummary {
  String email, totalAmountSpent, onElectricity, onWater, onSolar;

  TransactionSummary(
      {required this.email,
      required this.totalAmountSpent,
      required this.onElectricity,
      required this.onWater,
      required this.onSolar});

  factory TransactionSummary.fromJson(Map<String, dynamic> json) {
    return TransactionSummary(
      email: json["email"],
      totalAmountSpent: json["totalAmountSpent"],
      onElectricity: json["onElectricity"],
      onWater: json["onWater"],
      onSolar: json["onSolar"],
    );
  }
}
