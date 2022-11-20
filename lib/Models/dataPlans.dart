class DataPlans {
  String plan_code, name, amount;

  DataPlans(
      {required this.plan_code, required this.name, required this.amount});

  factory DataPlans.fromJson(Map<String, dynamic> json) {
    return DataPlans(
      plan_code: json["message"]["details"]["plans"]["plan_code"],
      name: json["message"]["details"]["plans"]["name"],
      amount: json["message"]["details"]["plans"]["amount"],
    );
  }
}
