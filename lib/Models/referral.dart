class Referrals {
  String refID, refEmail, userEmail, amount, status, dateCreated;

  Referrals(
      {required this.refID,
      required this.refEmail,
      required this.userEmail,
      required this.amount,
      required this.status,
      required this.dateCreated});

  factory Referrals.fromJson(Map<String, dynamic> json) {
    return Referrals(
      refID: json["refID"],
      refEmail: json["refEmail"],
      userEmail: json["userEmail"],
      amount: json["amount"],
      status: json["status"],
      dateCreated: json["dateCreated"],
    );
  }
}
