import 'package:buy_energy/Authentication/loginScreenDesktop.dart';
import 'package:buy_energy/Authentication/loginScreenMobile.dart';
import 'package:buy_energy/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: LoginScreenMobile(), desktopBody: LoginScreenDesktop());
  }
}
