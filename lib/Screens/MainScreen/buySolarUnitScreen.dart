import 'package:buy_energy/Screens/buyEnergyUnitScreenDesktop.dart';
import 'package:buy_energy/Screens/buyEnergyUnitScreenMobile.dart';
import 'package:buy_energy/Screens/buyWaterUnitScreenDesktop.dart';
import 'package:buy_energy/Screens/buyWaterUnitScreenMobile.dart';
import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import '../buySolarUnitScreenDesktop.dart';
import '../buySolarUnitScreenMobile.dart';

class BuySolarUnitScreen extends StatefulWidget {
  const BuySolarUnitScreen({Key? key}) : super(key: key);

  @override
  State<BuySolarUnitScreen> createState() => BuySolarUnitScreenState();
}

class BuySolarUnitScreenState extends State<BuySolarUnitScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: BuySolarUnitsScreenMobile(),
        desktopBody: BuySolarUnitsScreenDesktop());
    ;
  }
}
