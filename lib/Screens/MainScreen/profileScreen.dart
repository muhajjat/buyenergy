import 'package:buy_energy/Screens/homeScreenDesktop.dart';
import 'package:buy_energy/Screens/homeScreenMobile.dart';
import 'package:buy_energy/Screens/profileScreenDesktop.dart';
import 'package:buy_energy/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../profileScreenMobile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: ProfileScreenMobile(), desktopBody: ProfileScreenDesktop());
  }
}
