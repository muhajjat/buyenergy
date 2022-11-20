import 'package:buy_energy/Screens/buyEnergyUnitScreenDesktop.dart';
import 'package:buy_energy/Screens/buyEnergyUnitScreenMobile.dart';
import 'package:buy_energy/Screens/transactionScreenMobile.dart';
import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import '../referralScreenDesktop.dart';
import '../referralScreenMobile.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => ReferralScreenState();
}

class ReferralScreenState extends State<ReferralScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: ReferralScreenMobile(),
        desktopBody: ReferralScreenDesktop());

  }
}
