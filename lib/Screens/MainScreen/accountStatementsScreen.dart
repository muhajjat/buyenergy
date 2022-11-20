import 'package:buy_energy/Screens/accountStatementsScreenDesktop.dart';
import 'package:buy_energy/Screens/accountStatementsScreenMobile.dart';
import 'package:buy_energy/Screens/buyEnergyUnitScreenDesktop.dart';
import 'package:buy_energy/Screens/buyEnergyUnitScreenMobile.dart';
import 'package:buy_energy/Screens/orderHistoryScreenMobile.dart';
import 'package:buy_energy/Screens/transactionScreenMobile.dart';
import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';

class AccountStatementsScreen extends StatefulWidget {
  const AccountStatementsScreen({Key? key}) : super(key: key);

  @override
  State<AccountStatementsScreen> createState() => AccountStatementsScreenState();
}

class AccountStatementsScreenState extends State<AccountStatementsScreen> {
  @override
  Widget build(BuildContext context) {

    return ResponsiveLayout(
        mobileBody: AccountStatementsScreenMobile(), desktopBody: AccountStatementsScreenDesktop());

  }
}
