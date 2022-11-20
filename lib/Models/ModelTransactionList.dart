class ModelTransactionList {
  String transactionID, transactionType, email, fullName, date,
      time, meterNumber, amount, type, reference, billerName, token;

  ModelTransactionList({required this.transactionID,
    required this.transactionType,
    required this.email,
    required this.fullName,
    required this.date,
    required this.time,
    required this.meterNumber,
    required this.amount,
    required this.type,
    required this.reference,
    required this.billerName, required this.token});

  factory ModelTransactionList.fromJson(Map<String, dynamic> json){
    return ModelTransactionList(transactionID: json["transactionID"],
        transactionType: json["transactionType"],
        email: json["email"],
        fullName: json["fullName"],
        date: json["date"],
        time: json["time"],
        meterNumber: json["meterNumber"],
        amount: json["amount"],
        type: json["type"],
        reference: json["reference"],
        billerName:
        json["billerName"],
        token:
        json["token"]);
  }
}
