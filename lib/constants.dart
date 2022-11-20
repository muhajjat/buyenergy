import 'package:buy_energy/MyDatabase/MySharedPreferences.dart';
import 'package:buy_energy/Widgets/myDialogs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

import 'Widgets/loader.dart';

const primaryColor = Color(0xFF8837FD);
const secondaryColor = Colors.orange;
const appbarColor = Color(0xFFF5F7F6);
const menuIconsColor = Color(0xFFD4AF37);

const flutterwaveSecretCode =
    "FLWSECK-21a7b5b3e506b2d3101cf97665dc3aea-X"; // Test ID
const payscribeAuthorizationKey =
    "ps_live_71661bf3384c5589ec660887b35914bfa6967c002fdbcd376b8eab001f7808c8";
const productCodeAEDC =
    "0997F2191AE4D3804B1186DC935334A24A492B66039ED9DC7C4D743B5BA61991C0F0CF43D954793280FB37A11AB356026107C5AE82A71226B845BDA3F37DAB36|eyJwcm9kdWN0IjoiQUJVSkFFTEVDVFJJQ0lUWSIsInR5cGUiOiJWYWxpZGF0aW9uIiwiY3VzdG9tZXJNZXRlck5vIjoiNDUwMzE5MzA1MzUiLCJuYW1lIjoiS09MQVdPTEUgRVBIUklBTSIsImNsaWVudElkIjoiaXRleCIsInBhc3Njb2RlIjoiX2ludGUwYnZ4eioiLCJ1bmlxdWVjb2RlIjoiMDEyMzI0Mjg3NCIsImRhdGVUaW1lIjoiMjAyMS0wMS0yMyAwNTo0NCIsImRldmljZUlkIjoiMjAzMzAwMDkifQ%3D%3D";
const oneSignalAppID = "f374e945-81fd-4264-9b5a-a64a2e775e4b";
const paystackPublicKey = "pk_test_7bdbc44f8cd1adf3bea8c339219bf56fc69ecd45";

final numberFormatter = NumberFormat("#,##0.00", "en_US");
const double desktopRightMargin = 190; // Formally 250

class Constants {
  static String getCurrentDate() {
    final DateTime now = DateTime.now();
    return DateFormat('EEE d MMM yyyy').format(now);
  }

  static String getCurrentTime() {
    final DateTime now = DateTime.now();
    return DateFormat('hh:mm a').format(now);
  }

  static String getReferenceByTimestamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static Future<String> getEmail() async {
    String? email = await MySharedPreferences.getString(key: "email");

    return email!;
  }

  static Future<String> getFullName() async {
    String? fullName = await MySharedPreferences.getString(key: "fullName");

    return fullName!;
  }

  static Widget topMargin(double margin) {
    return Container(
      margin: EdgeInsets.only(top: margin),
    );
  }

  static Widget leftMargin(double margin) {
    return Container(
      margin: EdgeInsets.only(left: margin),
    );
  }

  static Widget rightMargin(double margin) {
    return Container(
      margin: EdgeInsets.only(right: margin),
    );
  }

  static Widget bottomMargin(double margin) {
    return Container(
      margin: EdgeInsets.only(bottom: margin),
    );
  }

  static goToNewPage(Widget page, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static goToNewPagePushReplacement(Widget page, BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static showToast({required String msg, required int timeInSecForIosWeb}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: timeInSecForIosWeb);
  }

  static showLoader(BuildContext context, String loaderDesc) async {
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      showDialog(
        barrierColor: Colors.white70,
        context: context,
        builder: (context) => MyLoader(loaderDesc),
      );
    } else {
      MyDialogs.showInfoDialog(context, "NO INTERNET CONNECTION",
          "Ooops! It seems you're not connected to the internet. Kindly confirm that you are connected to an active internet connection and try again. Thank you.");
    }
  }
}
