import 'package:buy_energy/Screens/buyEnergyUnitScreenDesktop.dart';
import 'package:buy_energy/Screens/buyEnergyUnitScreenMobile.dart';
import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';

class BuyEnergyUnitScreen extends StatefulWidget {
  const BuyEnergyUnitScreen({Key? key}) : super(key: key);

  @override
  State<BuyEnergyUnitScreen> createState() => _BuyEnergyUnitScreenState();
}

class _BuyEnergyUnitScreenState extends State<BuyEnergyUnitScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: BuyEnergyUnitsScreenMobile(), desktopBody: BuyEnergyUnitsScreenDesktop());;
  }
}
