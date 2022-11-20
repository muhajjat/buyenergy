import 'package:buy_energy/Screens/airtimePurchaseScreenMobile.dart';
import 'package:buy_energy/Screens/buyEnergyUnitScreenDesktop.dart';
import 'package:buy_energy/Screens/buyEnergyUnitScreenMobile.dart';
import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import '../cableTVScreenDesktop.dart';
import '../cableTVScreenMobile.dart';
import '../dataPurchaseScreenMobile.dart';

class CableTVScreen extends StatefulWidget {
  const CableTVScreen({Key? key}) : super(key: key);

  @override
  State<CableTVScreen> createState() => CableTVScreenState();
}

class CableTVScreenState extends State<CableTVScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: CableTVScreenMobile(), desktopBody: CableTVScreenDesktop());;
  }
}
