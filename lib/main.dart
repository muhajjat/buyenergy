import 'package:buy_energy/Authentication/MainAuthentication/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/MainScreen/homeScreen.dart';
import 'Screens/MainScreen/settingsScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool? isLoggedIn = sharedPreferences.getBool("isLoggedIn");

  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    home: isLoggedIn == true ? HomeScreen() : LoginScreen(),


  ));
}
