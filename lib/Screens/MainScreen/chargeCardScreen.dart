import 'package:buy_energy/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../chargeCardScreenDesktop.dart';



class ChargeCardScreen extends StatefulWidget {

  String walletAmount, email;

  ChargeCardScreen(this.walletAmount, this.email);


  @override
  State<ChargeCardScreen> createState() => ChargeCardScreenState();
}

class ChargeCardScreenState extends State<ChargeCardScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: ChargeCardScreenDesktop(widget.walletAmount, widget.email),
        desktopBody: ChargeCardScreenDesktop(widget.walletAmount, widget.email));
  }
}
