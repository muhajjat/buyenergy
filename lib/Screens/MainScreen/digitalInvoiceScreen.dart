import 'package:buy_energy/Screens/buyEnergyUnitScreenDesktop.dart';
import 'package:buy_energy/Screens/buyEnergyUnitScreenMobile.dart';
import 'package:buy_energy/Screens/digitalInvoiceScreenDesktop.dart';
import 'package:buy_energy/Screens/digitalInvoiceScreenMobile.dart';
import 'package:buy_energy/Screens/transactionScreenMobile.dart';
import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';

class DigitalInvoiceScreen extends StatefulWidget {
  const DigitalInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<DigitalInvoiceScreen> createState() => DigitalInvoiceScreenState();
}

class DigitalInvoiceScreenState extends State<DigitalInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: DigitalInvoiceScreenMobile(), desktopBody: DigitalInvoiceScreenDesktop());

  }
}
