import 'package:buy_energy/Screens/homeScreenDesktop.dart';
import 'package:buy_energy/Screens/homeScreenMobile.dart';
import 'package:buy_energy/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: HomeScreenMobile(), desktopBody: HomeScreenDesktop());
  }
}
