import 'dart:convert';
import 'dart:io';

import 'package:buy_energy/Widgets/myDialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../Models/bankDetails.dart';
import '../MyDatabase/MyDb.dart';
import '../Widgets/loader.dart';
import "package:http/http.dart" as http;

import '../constants.dart';

class QRPaymentScreen extends StatefulWidget {
  String bankName, accountName, accountNumber, swiftCode;


  QRPaymentScreen(
      this.bankName, this.accountName, this.accountNumber, this.swiftCode);

  @override
  State<QRPaymentScreen> createState() => QRPaymentScreenState();
}

class QRPaymentScreenState extends State<QRPaymentScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  late SharedPreferences sharedPreferences;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  getInstanceOfSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getInstanceOfSharedPref();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.all(7),
                child: const Center(
                  child: Text(
                    "Scan QR Code",
                    style: TextStyle(
                        fontSize: 21,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  // (result != null)
                  //     ? Text("Keembest Attendance")
                  //     //  Text('Keembest Attendance ${describeEnum(result!.format)}'.toUpperCase())
                  //     : Text('Scan QR Code'),
                )),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result!.code == "buyenergy") {
          controller.stopCamera();

          MyDialogs.showBankDetailsDialog(
              context,
              "Bank Details",
              "Bank Name: ${widget.bankName}\n"
                  "Account Name: ${widget.accountName}\n"
                  "Account Number: ${widget.accountNumber}\n"
                  "Swift Code: ${widget.swiftCode}");
        } else {
          Constants.showToast(
              msg: "Invalid QR Code. Please try again!", timeInSecForIosWeb: 2);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
