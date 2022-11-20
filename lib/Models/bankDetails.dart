class BankDetails {
  String bankName, accountName, accountNumber, swiftCode;

  BankDetails(
      {required this.bankName, required this.accountNumber, required this.accountName, required this.swiftCode});

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      bankName: json["BankDetails"]["bankName"],
      accountName: json["BankDetails"]["accountName"],
      accountNumber: json["BankDetails"]["accountNumber"],
      swiftCode: json["BankDetails"]["swiftCode"],

    );
  }
}
