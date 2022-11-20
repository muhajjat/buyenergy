import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';

class MyLoader extends StatefulWidget {
  String loaderDesc;

  MyLoader(this.loaderDesc);

  @override
  State<MyLoader> createState() => _MyLoaderState();
}

class _MyLoaderState extends State<MyLoader> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child:  Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const SpinKitFadingGrid(
                  color: primaryColor,
                ),
                Constants.topMargin(10),
                Text(widget.loaderDesc,
                  textAlign: TextAlign.center,
                  style: const TextStyle(

                     fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryColor
                  ),)
              ],
            )
        ),
      ),
    );
  }
}

