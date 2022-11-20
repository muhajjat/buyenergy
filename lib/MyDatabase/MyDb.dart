// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:buy_energy/Models/bankDetails.dart';
import 'package:buy_energy/Models/user.dart';
import 'package:buy_energy/Screens/homeScreenMobile.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../Data/companyDetails.dart';
import '../Models/transactionSummary.dart';
import '../Widgets/myDialogs.dart';
import '../constants.dart';
import '../enpoints.dart';
import 'MySharedPreferences.dart';

class MyDb {
  static final plugin = PaystackPlugin();
  static Dio dio = Dio();

  /// Initialize Paystack Plugin

  static initializePaystackPlugin() async {
    await plugin.initialize(publicKey: paystackPublicKey);
  }

  /// Charge Card For payment
  static chargeCardWithPaystack(
      {required BuildContext context,
      required String transactionType,
      required int amount,
      required String fullName,
      required String email,
      required String mobileNumber,
      required String date,
      required String time,
      required String dialogTitle,
      required String dialogDescription,
      required String screenType,
      String? plan,
      required String productCode,
      required String productToken,
      required String meterNo,
      required String biller,
      required String reference}) async {
    // Navigator.pop(context);
    // Constants.showLoader(context,
    //     "Meter Number Validation Successful!\nProcessing Payment. Please wait...");

    int amountToCharge = (amount * 100);

    Charge charge = Charge()
      ..amount = amountToCharge
      ..reference = DateTime.now().millisecondsSinceEpoch.toString()
      //..accessCode = "0peioxfhpn"
      ..email = email;
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      // Defaults to CheckoutMethod.selectable
      charge: charge,
    );

    if (response.status == true) {
      /// Payment is successful

      storePaymentLogs(
          email: email,
          amount: "$amount",
          date: date,
          time: time,
          reference: reference,
          transactionType: transactionType.toUpperCase());
      if (transactionType == "Electricity") {
        /// Test Store transaction
        // String? email = await MySharedPreferences.getString(key: "email");
        // String? fullName = await MySharedPreferences.getString(key: "fullName");
        //
        // storeTransactions(
        //   context: context,
        //   transactionType: transactionType,
        //   email: email!,
        //   fullName: fullName!,
        //   date: date,
        //   time: time,
        //   meterNo: meterNo!,
        //   amount: amount,
        //   biller: biller!,
        //   reference: reference,
        //   billerName: biller,
        //   token: "123",
        //   screenType: screenType,
        // );

        //   Buy Electricity

        /// Buy Electricity Units
        buyElectricityUnits(
          context: context,
          transactionType: transactionType,
          dialogTitle: dialogTitle,
          dialogDescription: dialogDescription,
          fullName: fullName,
          email: email,
          mobileNumber: mobileNumber,
          date: date,
          time: time,
          meterNo: meterNo,
          amount: amount,
          biller: biller,
          productCode: productCode,
          productToken: productToken,
          reference: reference,
          screenType: screenType,
        );
      } else if (transactionType == "Water") {
        //Constants.showLoader(context);
        MyDialogs.showSuccessDialog(
            context,
            "Successful",
            "Your bill payment was successful.\n\n"
                "Token: $reference");
      } else if (transactionType == "Solar") {
        //Constants.showLoader(context);
        MyDialogs.showSuccessDialog(
            context,
            "Successful",
            "Your bill payment was successful.\n\n"
                "Token: $reference");
      } else if (transactionType == "Airtime") {
        buyAirtime(
          context: context,
          transactionType: transactionType,
          fullName: fullName,
          email: email,
          mobileNumber: mobileNumber,
          date: date,
          time: time,
          biller: biller,
          amount: amount,
          reference: reference,
          screenType: screenType,
        );
      } else if (transactionType == "Data") {
        buyData(
          context: context,
          transactionType: transactionType,
          fullName: fullName,
          email: email,
          mobileNumber: mobileNumber,
          date: date,
          time: time,
          biller: biller,
          plan: plan!,
          amount: amount,
          reference: reference,
          screenType: screenType,
        );
      } else if (transactionType == "Cable TV") {
        payCableTVForMultichoice(
            context: context,
            transactionType: transactionType,
            amount: amount,
            fullName: fullName,
            email: email,
            mobileNumber: mobileNumber,
            date: date,
            time: time,
            dialogTitle: dialogTitle,
            dialogDescription: dialogDescription,
            meterNo: meterNo,
            meterType: "",
            biller: biller,
            reference: reference,
            plan: plan!,
            productCode: productCode,
            productToken: productToken,
            screenType: screenType);
      }
    } else {
      /// UNSUCCESSFUL
      Navigator.pop(context);
      Constants.showToast(
          msg: "Payment is Unsuccessful, Please Try again!",
          timeInSecForIosWeb: 3);
    }
  }

  /// Charge Card Directly
  static chargeCardDirectly(
      {required BuildContext context,
      required String cardNumber,
      required String expiryDate,
      required String cvvCode,
      required int amount,
      required String email}) async {
    var response = await http.post(Uri.parse(""),
        body: ({
          "cardNumber": cardNumber,
          "expiryDate": expiryDate,
          "cvv": cvvCode,
          "amount": "$amount"
        }));

    if (response.statusCode == 200) {
      storePaymentLogs(
          email: email,
          amount: "$amount",
          date: Constants.getCurrentDate(),
          time: Constants.getCurrentTime(),
          reference: Constants.getReferenceByTimestamp(),
          transactionType: "Energy Wallet Funding (WEB)".toUpperCase());

      /// ADD TO WALLET BALANCE
      var response = await http.post(Uri.parse(fundWalletEndpoint),
          body: ({"email": email, "walletAmount": "$amount"}));

      if (response.statusCode == 200) {
        HomeScreenMobileState.initializeFutureUsers();

        Navigator.pop(context);
        MyDialogs.showSuccessDialog(context, "Successful",
            "Your Energy Wallet has been successfully funded with ₦${numberFormatter.format(amount)}");
      } else {
        Navigator.pop(context);

        MyDialogs.showInfoDialog(context, "Error Occurred",
            "There was an error funding your wallet. Please try again.\n\nIf you were debited and your energy wallet is yet to be funded, please contact us via the following channel:\n\nEmail: $companyEmail\nMobile Number: $companyMobileNumber");
      }
    }
  }

  /// Charge From Energy Wallet
  static chargeFromEnergyWallet(
      {required BuildContext context,
      required String transactionType,
      required int amount,
      required String fullName,
      required String email,
      required String mobileNumber,
      required String date,
      required String time,
      required String dialogTitle,
      required String dialogDescription,
      required String screenType,
      required String productCode,
      required String productToken,
      required String meterNo,
      required String biller,
      String? plan,
      required String reference}) async {
    if (transactionType != "Airtime" &&
        transactionType != "Cable TV" &&
        transactionType != "Data") {
      Navigator.pop(context);
    }
    Constants.showLoader(context,
        "Customer ID Validated Successfully!\nProcessing Payment. Please wait...");

    var response = await http.post(Uri.parse(chargeWalletEndpoint),
        body: {"email": email, "walletAmount": "$amount"});

    if (response.statusCode == 200) {
      /// Payment is successful (From Energy Wallet)

      storePaymentLogs(
          email: email,
          amount: "$amount",
          date: date,
          time: time,
          reference: reference,
          transactionType: transactionType.toUpperCase());
      if (transactionType == "Electricity") {
        /// Test Store transaction
        // String? email = await MySharedPreferences.getString(key: "email");
        // String? fullName = await MySharedPreferences.getString(key: "fullName");
        //
        // storeTransactions(
        //   context: context,
        //   transactionType: transactionType,
        //   email: email!,
        //   fullName: fullName!,
        //   date: date,
        //   time: time,
        //   meterNo: meterNo!,
        //   amount: amount,
        //   biller: biller!,
        //   reference: reference,
        //   billerName: biller,
        //   token: "123",
        //   screenType: screenType,
        // );

        //   Buy Electricity

        /// Buy Electricity Units
        buyElectricityUnits(
          context: context,
          transactionType: transactionType,
          dialogTitle: dialogTitle,
          dialogDescription: dialogDescription,
          fullName: fullName,
          email: email,
          mobileNumber: mobileNumber,
          date: date,
          time: time,
          meterNo: meterNo,
          amount: amount,
          biller: biller,
          productCode: productCode,
          productToken: productToken,
          reference: reference,
          screenType: screenType,
        );
      } else if (transactionType == "Water") {
        String? email = await MySharedPreferences.getString(key: "email");
        String? fullName = await MySharedPreferences.getString(key: "fullName");

        storeTransactions(
          context: context,
          transactionType: transactionType,
          email: email!,
          fullName: fullName!,
          date: date,
          time: time,
          meterNo: meterNo,
          amount: amount,
          biller: biller,
          reference: reference,
          billerName: biller,
          token: "123",
          screenType: screenType,
        );
        // MyDialogs.showSuccessDialog(
        //     context,
        //     "Successful",
        //     "Your bill payment was successful.\n\n"
        //         "Token: $reference");
      } else if (transactionType == "Solar") {
        String? email = await MySharedPreferences.getString(key: "email");
        String? fullName = await MySharedPreferences.getString(key: "fullName");

        storeTransactions(
          context: context,
          transactionType: transactionType,
          email: email!,
          fullName: fullName!,
          date: date,
          time: time,
          meterNo: meterNo!,
          amount: amount,
          biller: biller!,
          reference: reference,
          billerName: biller,
          token: "123",
          screenType: screenType,
        );
        // MyDialogs.showSuccessDialog(
        //     context,
        //     "Successful",
        //     "Your bill payment was successful.\n\n"
        //         "Token: $reference");
      } else if (transactionType == "Airtime") {
        buyAirtime(
          context: context,
          transactionType: transactionType,
          fullName: fullName,
          email: email,
          mobileNumber: mobileNumber,
          date: date,
          time: time,
          biller: biller,
          amount: amount,
          reference: reference,
          screenType: screenType,
        );
      } else if (transactionType == "Data") {
        buyData(
          context: context,
          transactionType: transactionType,
          fullName: fullName,
          email: email,
          mobileNumber: mobileNumber,
          date: date,
          time: time,
          plan: plan!,
          biller: biller,
          amount: amount,
          reference: reference,
          screenType: screenType,
        );
      } else if (transactionType == "Cable TV") {
        if (transactionType == "Startimes") {
          payCableTVForStartimes(
              context: context,
              transactionType: transactionType,
              amount: amount,
              fullName: fullName,
              email: email,
              mobileNumber: mobileNumber,
              date: date,
              time: time,
              dialogTitle: dialogTitle,
              dialogDescription: dialogDescription,
              meterNo: meterNo,
              meterType: "",
              biller: biller,
              reference: reference,
              plan: plan!,
              productCode: productCode,
              productToken: productToken,
              screenType: screenType);
        } else {
          payCableTVForMultichoice(
              context: context,
              transactionType: transactionType,
              amount: amount,
              fullName: fullName,
              email: email,
              mobileNumber: mobileNumber,
              date: date,
              time: time,
              dialogTitle: dialogTitle,
              dialogDescription: dialogDescription,
              meterNo: meterNo,
              meterType: "",
              biller: biller,
              reference: reference,
              plan: plan!,
              productCode: productCode,
              productToken: productToken,
              screenType: screenType);
        }
      }
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      MyDialogs.showInfoDialog(
          context,
          "Insufficient Fund",
          "Sorry, you do not have sufficient funds in your Energy Wallet"
              " to carry out this transaction. Kindly fund your wallet and try again"
              " or use your card to complete this transaction. Thank you");
    } else {
      Navigator.pop(context);

      /// UNSUCCESSFUL
      Constants.showToast(
          msg: "Payment was Unsuccessful, Please Try again!",
          timeInSecForIosWeb: 3);
    }
  }

  static validateMeterNumber(
      {required BuildContext context,
      required String transactionType,
      required int amount,
      required String fullName,
      required String email,
      required String mobileNumber,
      required String date,
      required String time,
      required String dialogTitle,
      required String dialogDescription,
      required String meterNo,
      required String meterType,
      required String biller,
      required String reference,
      required String screenType,
      required String paymentMethod}) async {
    Constants.showLoader(context, "Validating Meter Number...");

    var response = await http.post(Uri.parse(validateElectricityEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $payscribeAuthorizationKey',
        },
        body: json.encode({
          "meter_number": meterNo,
          "meter_type": meterType,
          "amount": "$amount",
          "service": biller,
        }));

    var validateDecoded = json.decode(response.body);

    if (response.statusCode == 200) {
      String message = validateDecoded["message"].toString();

      if (message.contains("There was an error validating")) {
        Navigator.pop(context);
        MyDialogs.showInfoDialog(context, "ERROR OCCURRED", message);
      } else {
        String productCode =
            validateDecoded["message"]["details"]["productCode"].toString();
        String productToken =
            validateDecoded["message"]["details"]["productToken"].toString();

        // Constants.showToast(msg: productCode, timeInSecForIosWeb: 3);

        if (paymentMethod == "card") {
          chargeCardWithPaystack(
              context: context,
              transactionType: transactionType,
              amount: amount,
              fullName: fullName,
              email: email,
              mobileNumber: mobileNumber,
              date: date,
              time: time,
              dialogTitle: dialogTitle,
              dialogDescription: dialogDescription,
              screenType: screenType,
              meterNo: meterNo,
              biller: biller,
              productCode: productCode,
              productToken: productToken,
              reference: reference);
        } else {
          chargeFromEnergyWallet(
              context: context,
              transactionType: transactionType,
              amount: amount,
              fullName: fullName,
              email: email,
              mobileNumber: mobileNumber,
              date: date,
              time: time,
              dialogTitle: dialogTitle,
              dialogDescription: dialogDescription,
              screenType: screenType,
              meterNo: meterNo,
              biller: biller,
              productCode: productCode,
              productToken: productToken,
              reference: reference);
        }
      }
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Error Code: ${response.statusCode}\n"
              "${validateDecoded["message"]}");
    }
  }

  static payCableTVForMultichoice({
    required BuildContext context,
    required String transactionType,
    required int amount,
    required String fullName,
    required String email,
    required String mobileNumber,
    required String date,
    required String time,
    required String dialogTitle,
    required String dialogDescription,
    required String meterNo,
    required String meterType,
    required String biller,
    required String reference,
    required String plan,
    required String productCode,
    required String productToken,
    required String screenType,
  }) async {
    Navigator.pop(context);
    Constants.showLoader(context,
        "Payment Successful!\nBill payment in progress. Please wait...");

    var response = await http.post(
        Uri.parse(
          payMultichoiceCableTVEndpoint,
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $payscribeAuthorizationKey',
        },
        body: json.encode({
          "plan": plan,
          "productCode": productCode,
          "phone": mobileNumber,
          "productToken": productToken,
          "trans_id": reference
        }));

    if (response.statusCode == 200) {
      storeTransactions(
        context: context,
        transactionType: transactionType,
        email: email,
        fullName: fullName,
        date: date,
        time: time,
        meterNo: meterNo,
        amount: amount,
        biller: biller,
        reference: reference,
        billerName: biller,
        token: "Null",
        screenType: screenType,
      );
    } else {
      var decoded = jsonDecode(response.body);
      Navigator.pop(context);
      Constants.showToast(
          msg: "Error Occurred: ${decoded["message"]["description"]}",
          timeInSecForIosWeb: 3);
    }
  }

  static payCableTVForStartimes({
    required BuildContext context,
    required String transactionType,
    required int amount,
    required String fullName,
    required String email,
    required String mobileNumber,
    required String date,
    required String time,
    required String dialogTitle,
    required String dialogDescription,
    required String meterNo,
    required String meterType,
    required String biller,
    required String reference,
    required String plan,
    required String productCode,
    required String productToken,
    required String screenType,
  }) async {
    Navigator.pop(context);
    Constants.showLoader(context,
        "Payment Successful!\nBill payment in progress. Please wait...");

    var response = await http.post(
        Uri.parse(
          payStartimesCableTVEndpoint,
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $payscribeAuthorizationKey',
        },
        body: json.encode({
          "bouquet": plan,
          "cycle": "weekly",
          "productCode": productCode,
          "phone": mobileNumber,
          "productToken": productToken,
          "trans_id": reference
        }));

    if (response.statusCode == 200) {
      storeTransactions(
        context: context,
        transactionType: transactionType,
        email: email,
        fullName: fullName,
        date: date,
        time: time,
        meterNo: meterNo,
        amount: amount,
        biller: biller,
        reference: reference,
        billerName: biller,
        token: "Null",
        screenType: screenType,
      );
    } else {
      var decoded = jsonDecode(response.body);
      Navigator.pop(context);
      Constants.showToast(
          msg: "Error Occurred: ${decoded["message"]["description"]}",
          timeInSecForIosWeb: 3);
    }
  }

  static buyElectricityUnits(
      {required BuildContext context,
      required String transactionType,
      required int amount,
      required String fullName,
      required String email,
      required String mobileNumber,
      required String date,
      required String time,
      required String dialogTitle,
      required String dialogDescription,
      required String meterNo,
      required String biller,
      required String productCode,
      required String productToken,
      required String reference,
      required String screenType}) async {
    Navigator.pop(context);
    Constants.showLoader(context,
        "Payment Successful!\nGenerating your bill token. Please wait...");

    var response = await http.post(Uri.parse(electricityPaymentEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $payscribeAuthorizationKey',
        },
        body: json.encode({
          "productCode": productCode,
          "productToken": productToken,
          "phone": mobileNumber,
        }));

    var decoded = json.decode(response.body);

    if (response.statusCode == 200) {
      // Navigator.pop(context);
      //
      // Constants.showToast(msg: "Success\n\n$token", timeInSecForIosWeb: 3);

      String message = decoded["message"].toString();

      if (message.contains("There was an error")) {
        Navigator.pop(context);
        MyDialogs.showInfoDialog(context, "ERROR OCCURRED",
            "$message\n\nPlease try again later or contact our customer service support for further assistance. Thank you!");
      } else {
        String token = decoded["message"]["details"]["token"].toString();
        storeTransactions(
          context: context,
          transactionType: transactionType,
          email: email,
          fullName: fullName,
          date: date,
          time: time,
          meterNo: meterNo,
          amount: amount,
          biller: biller,
          reference: reference,
          billerName: biller,
          token: token,
          screenType: screenType,
        );
      }
    } else{


      Navigator.pop(context);
      String errorMessage = decoded["message"]["description"].toString();

      Constants.showToast(msg: errorMessage, timeInSecForIosWeb: 3);
    }
  }

  static void storeTransactions(
      {required BuildContext context,
      required String transactionType,
      required String email,
      required String fullName,
      required String date,
      required String time,
      required String meterNo,
      required int amount,
      required String biller,
      required String reference,
      required String billerName,
      required String token,
      required String screenType}) async {
    var response = await http.post(Uri.parse(storeTransactionsEndpoint),
        body: ({
          "transactionType": transactionType,
          "email": email,
          "fullName": fullName,
          "date": date,
          "time": time,
          "meterNumber": meterNo,
          "amount": "$amount",
          "type": biller,
          "reference": reference,
          "billerName": billerName,
          "token": token
        }));

    if (response.statusCode == 200) {
      if (screenType == "Mobile") {
        // Update data in Mobile Screen
        HomeScreenMobileState.initializeFutureSummary();
      } else {
        // Update data in Desktop
        //  HomeScreenDesktopState.futureSummary;
      }

      MyDialogs.showSuccessDialogForBillPayment(
          context,
          "Successful",
          "Your bill payment was successful.\n\n$transactionType" == "Airtime"
              ? ""
              : "Token: $token\n"
                  "Ref: $reference");
    } else {
      Navigator.pop(context);
      Constants.showToast(
          msg: "Error occurred. Please try again!\n"
              "Error Code: ${response.statusCode}",
          timeInSecForIosWeb: 3);
    }
  }

  static syncBaseUrl() {
    if (!kIsWeb) {
      dio.interceptors.add(
          DioCacheManager(CacheConfig(baseUrl: baseUrlEndpoint)).interceptor);
    }
  }

  static Future<User> fetchUserDetails() async {
    String? email = await MySharedPreferences.getString(key: "email");

    Response response = await dio.get(userDetailsEndpoint + email!,
        options: buildCacheOptions(
          const Duration(days: 7), //duration of cache
          forceRefresh: true, //to force refresh
          maxStale: const Duration(days: 10), //before this time, if error like
          //500, 500 happens, it will return cache
        ));

    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw Exception('No user record found');
    }
  }

  static Future<TransactionSummary> fetchSummary() async {
    String? email = await MySharedPreferences.getString(key: "email");

    Response response = await dio.get(summaryEndpoint + email!,
        options: buildCacheOptions(
          const Duration(days: 7), //duration of cache
          forceRefresh: true, //to force refresh
          maxStale: const Duration(days: 10), //before this time, if error like
          //500, 500 happens, it will return cache
        ));

    if (response.statusCode == 200) {
      return TransactionSummary.fromJson(response.data);
    } else {
      throw Exception('No summary record found');
    }
  }

  static Future<BankDetails> fetchBankDetails() async {
    Response response = await dio.get(bankDetailsEndpoint,
        options: buildCacheOptions(
          const Duration(days: 7), //duration of cache
          forceRefresh: true, //to force refresh
          maxStale: const Duration(days: 10), //before this time, if error like
          //500, 500 happens, it will return cache
        ));

    if (response.statusCode == 200) {
      return BankDetails.fromJson(response.data);
    } else {
      throw Exception('No bank record found');
    }
  }

  static updateUserDetailsOnSharedPreference() async {
    String? email = await MySharedPreferences.getString(key: "email");
    var response = await http.get(Uri.parse(userDetailsEndpoint + email!));

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      await MySharedPreferences.setString(
          key: "fullName",
          value: decoded["users_data"]["firstName"] +
              " " +
              decoded["users_data"]["lastName"]);
    }
  }

  static fundEnergyWallet({
    required BuildContext context,
    required String email,
    required int walletAmount,
    required String screenType,
  }) async {
    Constants.showLoader(context, "Loading. Please wait...");

    int amountToCharge = (walletAmount * 100);

    Charge charge = Charge()
      ..amount = amountToCharge
      ..reference = DateTime.now().millisecondsSinceEpoch.toString()
      //..accessCode = "0peioxfhpn"
      ..email = email;
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      // Defaults to CheckoutMethod.selectable
      charge: charge,
    );

    if (response.status == true) {
      /// Payment is successful
      storePaymentLogs(
          email: email,
          amount: "$amountToCharge",
          date: Constants.getCurrentDate(),
          time: Constants.getCurrentTime(),
          reference: Constants.getReferenceByTimestamp(),
          transactionType: "Energy Wallet Funding".toUpperCase());

      var response = await http.post(Uri.parse(fundWalletEndpoint),
          body: ({"email": email, "walletAmount": "$walletAmount"}));

      if (response.statusCode == 200) {
        if (screenType == "Mobile") {
          // Mobile Screen

          HomeScreenMobileState.initializeFutureUsers();
        }
        {
          // Desktop Screen
        }

        Navigator.pop(context);
        MyDialogs.showSuccessDialog(context, "Successful",
            "Your Energy Wallet has been successfully funded with ₦${numberFormatter.format(walletAmount)}");
      } else {
        Navigator.pop(context);

        MyDialogs.showInfoDialog(context, "Error Occurred",
            "There was an error funding your wallet. Please try again.\n\nIf you were debited and your energy wallet is yet to be funded, please contact us via the following channel:\n\nEmail: $companyEmail\nMobile Number: $companyMobileNumber");
      }
    } else {
      /// UNSUCCESSFUL
      Navigator.pop(context);
      Constants.showToast(
          msg: "Payment was Unsuccessful, Please Try again!",
          timeInSecForIosWeb: 3);
    }
  }

  static updatePassword(
      {required BuildContext context,
      required String oldPassword,
      required String newPassword}) async {
    String? email = await MySharedPreferences.getString(key: "email");

    Constants.showLoader(context, "Updating your password in our server...");

    var response = await http.post(Uri.parse(updatePasswordEndpoint),
        body: ({
          "email": email!,
          "oldPassword": oldPassword,
          "newPassword": newPassword
        }));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Password Successfully Updated",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3);
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Old password is incorrect, please try again",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3);
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg:
              "Error updating password. Please try again! ${response.statusCode.toString()}\n",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3);
    }
  }

  static storePaymentLogs({
    required String email,
    required String amount,
    required String date,
    required String time,
    required String reference,
    required String transactionType,
  }) async {
    var response = await http.post(Uri.parse(storePaymentLogsEndpoint),
        body: ({
          "email": email,
          "amount": amount,
          "date": date,
          "time": time,
          "reference": reference,
          "transactionType": transactionType
        }));

    // if (response.statusCode == 200) {
    //   Constants.showToast(msg: "Success Success", timeInSecForIosWeb: 1);
    // } else {
    //   Constants.showToast(
    //       msg: "Error: ${response.statusCode}", timeInSecForIosWeb: 1);
    // }
  }

  static resetPassword(
      {required BuildContext context, required String email}) async {
    Constants.showLoader(
        context, "Requesting for a new password.\nPlease wait...");

    var response = await http.post(Uri.parse(passwordResetEndpoint),
        body: ({"email": email}));
    if (response.statusCode == 200) {
      var passwordDecoded = jsonDecode(response.body);
      String updatedPassword = "${passwordDecoded["data"]}";

      sendUpdatedPasswordToEmail(
          context: context, email: email, updatedPassword: updatedPassword);
    } else {
      Navigator.pop(context);
      Constants.showToast(
          msg: "Error Occurred: ${response.statusCode}", timeInSecForIosWeb: 3);
    }
  }

  static void sendUpdatedPasswordToEmail(
      {required BuildContext context,
      required String email,
      required String updatedPassword}) async {
    var response = await http.post(Uri.parse(sendEmailEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "service_id": 'service_yhpjxtc',
          "template_id": 'template_aa02dds',
          "user_id": 'KoWzEC5LP90Cr_RpE',
          "template_params": {
            "user_email": email,
            "name": email,
            "email": email,
            "subject": "PASSWORD RESET FOR BUY ENERGY UNITS",
            "message":
                "Your password has been updated successfully. Your new password is $updatedPassword\n"
                    "Please don't reveal this password to anyone. To change your password, log into your account and update your password under the settings. Thank you.\n\n"
                    "Regards,"
                    "Buy Energy Units Team."
          }
        }));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      MyDialogs.showSuccessDialog(context, "PASSWORD RESET SUCCESSFUL",
          "We have sent your new password to your email address. You can use the new password to login and change it under your settings. Thank you");
    } else {
      Navigator.pop(context);
      Constants.showToast(
          msg: "Error Occurred: ${response.statusCode}\n"
              "${response.body}",
          timeInSecForIosWeb: 3);
    }
  }

  static buyAirtime(
      {required BuildContext context,
      required String transactionType,
      required String fullName,
      required String email,
      required String mobileNumber,
      required String date,
      required String time,
      required String biller,
      required int amount,
      required String reference,
      required String screenType}) async {
    Navigator.pop(context);
    Constants.showLoader(context, "Purchasing Airtime...");

    var response = await http.post(Uri.parse(airtimePurchaseEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $payscribeAuthorizationKey',
        },
        body: json.encode({
          "network": biller.toLowerCase(),
          "amount": amount,
          "recipent": mobileNumber,
          "ported": false
        }));

    if (response.statusCode == 200) {
      storeTransactions(
        context: context,
        transactionType: transactionType,
        email: email,
        fullName: fullName,
        date: date,
        time: time,
        meterNo: mobileNumber,
        amount: amount,
        biller: biller,
        reference: reference,
        billerName: biller,
        token: "NIL",
        screenType: screenType,
      );
    } else {
      Navigator.pop(context);
      Constants.showToast(
          msg: "${response.statusCode}\n"
              "${response.body}",
          timeInSecForIosWeb: 3);
    }
  }

  static buyData(
      {required BuildContext context,
      required String transactionType,
      required String fullName,
      required String email,
      required String mobileNumber,
      required String date,
      required String time,
      required String biller,
      required String plan,
      required int amount,
      required String reference,
      required String screenType}) async {
    Navigator.pop(context);
    Constants.showLoader(context, "Purchasing Data...");

    var response = await http.post(Uri.parse(dataPurchaseEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $payscribeAuthorizationKey',
        },
        body: json.encode({
          "plan": plan,
          "recipent": mobileNumber,
          "network": biller.toLowerCase(),
        }));

    if (response.statusCode == 200) {
      storeTransactions(
        context: context,
        transactionType: transactionType,
        email: email,
        fullName: fullName,
        date: date,
        time: time,
        meterNo: mobileNumber,
        amount: amount,
        biller: biller,
        reference: reference,
        billerName: biller,
        token: "NIL",
        screenType: screenType,
      );
    } else {
      Navigator.pop(context);
      Constants.showToast(
          msg: "${response.statusCode}\n"
              "${response.body}",
          timeInSecForIosWeb: 3);
    }
  }
}
