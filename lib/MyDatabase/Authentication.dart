import 'package:buy_energy/Screens/MainScreen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/loader.dart';
import '../constants.dart';
import '../enpoints.dart';
import 'MySharedPreferences.dart';

class Authentication {
  static loginUser(
      {required BuildContext context, required String email,required String password}) async {
    showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => MyLoader("Authenticating. Please wait..."),
    );
    var response = await http.post(Uri.parse(loginEndpoint),
        body: ({
          "email": email,
          "password": password,
        }));

    //  Fluttertoast.showToast(msg: deviceId!);
    if (response.statusCode == 200) {

      MySharedPreferences.setBool(key: "isLoggedIn", value: true);
      MySharedPreferences.setString(key: "email", value: email);
      Constants.showToast(msg: "Login Successful", timeInSecForIosWeb: 3);
      Navigator.pop(context);
      /// Go to New Page
      Constants.goToNewPagePushReplacement(HomeScreen(), context);
    } else if (response.statusCode == 400) {
      Navigator.pop(context);

      Constants.showToast(
          msg: "Incorrect ID and/or password", timeInSecForIosWeb: 3);
    } else {
      Navigator.pop(context);

      Constants.showToast(
          msg: "Error occurred. Please try again:\n"
              "Code: ${response.statusCode}", timeInSecForIosWeb: 3);
    }
  }

  static signUp(
      {required BuildContext context,
      required String firstName,
      required String lastName,
      required String email,
      required String country,
      required String mobileNumber,
        required String refEmail,
      required String password}) async {
    showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => MyLoader("Creating New User..."),
    );
    var response = await http.post(Uri.parse(singupEndpoint),
        body: ({
          "firstName": firstName,
          "lastName": lastName,
          "mobileNumber": mobileNumber,
          "email": email,
          "refEmail" : refEmail,
          "country": country,
          "password": password,
        }));

    //  Fluttertoast.showToast(msg: deviceId!);
    if (response.statusCode == 200) {


      MySharedPreferences.setBool(key: "isLoggedIn", value: true);
      MySharedPreferences.setString(key: "email", value: email);
      Constants.showToast(msg: "Signup Successful", timeInSecForIosWeb: 3);

      Navigator.pop(context);
      /// Go to New Page
        Constants.goToNewPagePushReplacement(HomeScreen(), context);
    } else if (response.statusCode == 400) {
      Navigator.pop(context);

      Constants.showToast(
          msg: "Email already exist. Try another email", timeInSecForIosWeb: 3);
    } else {
      Navigator.pop(context);

      Constants.showToast(
          msg: "Error occurred. Please try again\n"
              "Code: ${response.statusCode}", timeInSecForIosWeb: 3);
    }
  }
}
