class User {
  String firstName, lastName, mobileNumber, email, country, walletAmount;

  User(
      {required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.email,
      required this.country,
      required this.walletAmount});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json["users_data"]["firstName"],
      lastName: json["users_data"]["lastName"],
      mobileNumber: json["users_data"]["mobileNumber"],
      email: json["users_data"]["email"],
      country: json["users_data"]["country"],
      walletAmount: json["users_data"]["walletAmount"],
    );
  }
}
