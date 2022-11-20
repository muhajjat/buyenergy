import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import '../dataPurchaseScreenDesktop.dart';
import '../dataPurchaseScreenMobile.dart';

class DataPurchaseScreen extends StatefulWidget {
  const DataPurchaseScreen({Key? key}) : super(key: key);

  @override
  State<DataPurchaseScreen> createState() => DataPurchaseScreenState();
}

class DataPurchaseScreenState extends State<DataPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: DataPurchaseScreenMobile(),
        desktopBody: DataPurchaseScreenDesktop());
   }
}
