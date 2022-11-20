import 'package:buy_energy/Screens/homeScreenDesktop.dart';
import 'package:buy_energy/Screens/homeScreenMobile.dart';
import 'package:buy_energy/Screens/profileScreenDesktop.dart';
import 'package:buy_energy/Screens/settingsScreenDesktop.dart';
import 'package:buy_energy/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../profileScreenMobile.dart';
import '../settingsScreenMobile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: SettingsScreenMobile(), desktopBody: SettingsScreenDesktop());
  }
}
