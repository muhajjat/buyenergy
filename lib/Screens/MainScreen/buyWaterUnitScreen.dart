import 'package:buy_energy/Screens/buyEnergyUnitScreenDesktop.dart';
import 'package:buy_energy/Screens/buyEnergyUnitScreenMobile.dart';
import 'package:buy_energy/Screens/buyWaterUnitScreenDesktop.dart';
import 'package:buy_energy/Screens/buyWaterUnitScreenMobile.dart';
import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';

class BuyWaterUnitScreen extends StatefulWidget {
  const BuyWaterUnitScreen({Key? key}) : super(key: key);

  @override
  State<BuyWaterUnitScreen> createState() => BuyWaterUnitScreenState();
}

class BuyWaterUnitScreenState extends State<BuyWaterUnitScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: BuyWaterUnitsScreenMobile(), desktopBody: BuyWaterUnitsScreenDesktop());
  }
}
