import 'package:buy_energy/Screens/faqScreenDesktop.dart';
import 'package:buy_energy/Screens/faqScreenMobile.dart';
import 'package:flutter/material.dart';

import '../../Data/faqs.dart';
import '../../responsive/responsive_layout.dart';

class FAQScreen extends StatefulWidget {


  @override
  State<FAQScreen> createState() => FAQScreenState();
}

class FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {

    return ResponsiveLayout(
        mobileBody: FAQScreenMobile(
          faqDetail: faqs[0],

        ), desktopBody: FAQScreenDesktop(
      faqDetail: faqs[0],

    ),);

  }
}
