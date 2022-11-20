class CableTV {
  String name, amount, plan;

  CableTV({required this.name, required this.amount, required this.plan});

  factory CableTV.fromJson(Map<String, dynamic> json) {
    return CableTV(
      name: json["message"]["details"]["bouquets"]["name"],
      amount: json["message"]["details"]["bouquets"]["amount"],
      plan: json["message"]["details"]["bouquets"]["plan"],
    );
  }
}
