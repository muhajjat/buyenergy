import 'package:buy_energy/Screens/buyEnergyUnitScreenDesktop.dart';
import 'package:buy_energy/Screens/buyEnergyUnitScreenMobile.dart';
import 'package:buy_energy/Screens/orderHistoryScreenDesktop.dart';
import 'package:buy_energy/Screens/orderHistoryScreenMobile.dart';
import 'package:buy_energy/Screens/transactionScreenMobile.dart';
import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => OrderHistoryScreenState();
}

class OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {

    return ResponsiveLayout(
        mobileBody: OrderHistoryScreenMobile(), desktopBody: OrderHistoryScreenDesktop());

  }
}
