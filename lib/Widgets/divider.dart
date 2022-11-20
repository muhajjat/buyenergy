import 'package:flutter/material.dart';

import '../constants.dart';

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 50, height: 5, color: primaryColor),
        SizedBox(width: 10),
        Container(width: 25, height: 5, color: primaryColor),
        SizedBox(width: 10),
        Container(width: 10, height: 5, color: primaryColor),
      ],
    );
  }
}
