import 'package:buy_energy/Screens/airtimePurchaseScreenMobile.dart';
import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import '../airtimePurchaseScreenDesktop.dart';

class AirtimePurchaseScreen extends StatefulWidget {
  const AirtimePurchaseScreen({Key? key}) : super(key: key);

  @override
  State<AirtimePurchaseScreen> createState() => AirtimePurchaseScreenState();
}

class AirtimePurchaseScreenState extends State<AirtimePurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: AirtimePurchaseScreenMobile(),
        desktopBody: AirtimePurchaseScreenDesktop());
  }
}
