import 'package:buy_energy/Authentication/signupScreenDesktop.dart';
import 'package:buy_energy/Authentication/signupScreenMobile.dart';
import 'package:buy_energy/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileBody: SignupScreenMobile(), desktopBody: SignupScreenDesktop());
  }
}
