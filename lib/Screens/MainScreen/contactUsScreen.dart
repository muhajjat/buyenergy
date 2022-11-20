import 'package:buy_energy/Screens/contactUsScreenDesktop.dart';
import 'package:buy_energy/Screens/contactUsScreenMobile.dart';
import 'package:buy_energy/Screens/homeScreenDesktop.dart';
import 'package:buy_energy/Screens/homeScreenMobile.dart';
import 'package:buy_energy/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../profileScreenMobile.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => ContactUsScreenState();
}

class ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: ContactUsScreenMobile(), desktopBody: ContactUsScreenDesktop());
  }
}
