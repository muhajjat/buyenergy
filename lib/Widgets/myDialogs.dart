// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:buy_energy/Authentication/MainAuthentication/loginScreen.dart';
import 'package:buy_energy/MyDatabase/MyDb.dart';
import 'package:buy_energy/Screens/MainScreen/homeScreen.dart';
import 'package:buy_energy/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDialogs {
  static AwesomeDialog showSummaryDialog(
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
      String? meterNo,
      String? meterType,
      String? biller,
      required String reference}) {
    return AwesomeDialog(
      context: context,
      width: 500,
      body: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(
                dialogTitle,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              Constants.topMargin(5),
              Text(
                dialogDescription,
                style: const TextStyle(fontSize: 17),
              )
            ],
          )),
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      btnOkColor: Colors.deepPurple,
      btnCancelColor: Colors.red,
      title: dialogTitle,
      btnOkText: "Confirm",
      desc: dialogDescription,
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        showPaymentMethodDialog(
          context: context,
          transactionType: transactionType,
          amount: amount,
          fullName: fullName,
          email: email,
          date: date,
          time: time,
          meterNo: meterNo,
          meterType: meterType,
          mobileNumber: mobileNumber,
          biller: biller,
          dialogTitle: dialogTitle,
          dialogDescription: dialogDescription,
          reference: reference,
          screenType: screenType,
        );
      },
    )..show();
  }

  static AwesomeDialog showPaymentMethodDialog(
      {required BuildContext context,
      required String transactionType,
      required int amount,
      required String fullName,
      required String email,
      required String date,
      required String time,
      required String dialogTitle,
      required String mobileNumber,
      required String dialogDescription,
      required String screenType,
      String? plan,
      String? productCode,
      String? productToken,
      String? meterNo,
      String? meterType,
      String? biller,
      required String reference}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      btnOkColor: primaryColor,
      btnCancelColor: Colors.deepPurpleAccent,
      width: 500,
      title: "PAYMENT METHOD",
      desc: "Please select your preferred payment method to proceed",
      btnOkText: "Energy Wallet",
      btnCancelText: "Card",
      btnCancelOnPress: () {
        /// Pay with Card (Validate First)

        if (!kIsWeb) {
          if (transactionType == "Airtime") {
            MyDb.chargeCardWithPaystack(
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
                plan: plan!,
                productCode: "",
                productToken: "",
                meterNo: meterNo!,
                biller: biller!,
                reference: reference);
          }  else if (transactionType == "Data") {
            MyDb.chargeCardWithPaystack(
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
                plan: plan!,
                productCode: "",
                productToken: "",
                meterNo: meterNo!,
                biller: biller!,
                reference: reference);
          } else if (transactionType == "Cable TV") {
            MyDb.chargeCardWithPaystack(
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
                productCode: productCode!,
                productToken: productToken!,
                meterNo: meterNo!,
                biller: biller!,
                reference: reference);
          } else {
            MyDb.validateMeterNumber(
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
                meterNo: meterNo!,
                meterType: meterType!,
                biller: biller!,
                reference: reference,
                screenType: screenType,
                paymentMethod: "card");
          }
        } else {
          Constants.showToast(
              msg:
                  "Sorry, card payment is not available for web, fund and use your energy wallet instead.",
              timeInSecForIosWeb: 3);
        }
      },
      btnOkOnPress: () {
        /// Pay with Energy Wallet (Validate first)

        //  Constants.showToast(msg: biller!, timeInSecForIosWeb: 3);

        if (transactionType == "Airtime") {
          MyDb.chargeFromEnergyWallet(
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
              productCode: "",
              productToken: "",
              meterNo: meterNo!,
              biller: biller!,
              reference: reference);
        }  else if (transactionType == "Data") {
          MyDb.chargeFromEnergyWallet(
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
              productCode: "",
              productToken: "",
              meterNo: meterNo!,
              biller: biller!,
              plan: plan,
              reference: reference);
        } else if (transactionType == "Cable TV") {
          MyDb.chargeFromEnergyWallet(
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
              plan: plan!,
              productCode: productCode!,
              productToken: productToken!,
              meterNo: meterNo!,
              biller: biller!,
              reference: reference);
        } else {
          MyDb.validateMeterNumber(
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
              meterNo: meterNo!,
              meterType: meterType!,
              biller: biller!,
              reference: reference,
              screenType: screenType,
              paymentMethod: "energyWallet");
        }
      },
    )..show();
  }

  static AwesomeDialog showSuccessDialog(
    BuildContext context,
    String title,
    String description,
  ) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      btnOkColor: Colors.green,
      width: 500,
      dismissOnTouchOutside: true,
      title: title,
      desc: description,
      btnOkText: "Okay, Thanks!",
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    )..show();
  }

  static AwesomeDialog showSuccessDialogForBillPayment(
    BuildContext context,
    String title,
    String description,
  ) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      btnOkColor: Colors.green,
      width: 500,
      dismissOnTouchOutside: false,
      title: title,
      desc: description,
      btnOkText: "Okay, Thanks!",
      btnOkOnPress: () {
        Constants.goToNewPagePushReplacement(const HomeScreen(), context);
      },
    )..show();
  }

  static AwesomeDialog showInfoDialog(
    BuildContext context,
    String title,
    String description,
  ) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      btnOkColor: Colors.orange,
      width: 500,
      title: title,
      desc: description,
      dismissOnTouchOutside: true,
      btnOkOnPress: () {},
    )..show();
  }

  static AwesomeDialog showLogoutDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      btnOkColor: primaryColor,
      btnCancelColor: Colors.deepPurpleAccent,
      width: 500,
      title: "Confirm Logout",
      desc: "Are you sure you want to logout now?",
      btnOkText: "Yes",
      btnCancelText: "No",
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool("isLoggedIn", false).then((value) {
          Constants.goToNewPagePushReplacement(const LoginScreen(), context);

          Constants.showToast(msg: "Logout Successful!", timeInSecForIosWeb: 3);
        });
      },
    )..show();
  }

  static AwesomeDialog showBankDetailsDialog(
    BuildContext context,
    String title,
    String description,
  ) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      btnOkColor: Colors.orange,
      width: 500,
      title: title,
      desc: description,
      dismissOnTouchOutside: false,
      btnOkOnPress: () {
        Constants.goToNewPagePushReplacement(const HomeScreen(), context);
      },
    )..show();
  }

  static Future<void> showForgotPasswordDialog(BuildContext context) async {
    String email = "";
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Reset'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  cursorColor: primaryColor,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                      hintText: "Email Address",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor))),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Reset Password'.toUpperCase(),
                style: TextStyle(color: primaryColor),
              ),
              onPressed: () async {
                if (email == "") {
                  Constants.showToast(
                      msg: "Enter your email address to continue",
                      timeInSecForIosWeb: 3);
                } else {
                  //Navigator.pop(context);
                  MyDb.resetPassword(context: context, email: email);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
