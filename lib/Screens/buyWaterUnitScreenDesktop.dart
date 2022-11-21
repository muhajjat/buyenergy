import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:buy_energy/Widgets/myDialogs.dart';
import 'package:buy_energy/enpoints.dart';
import 'package:buy_energy/Data/billers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../MyDatabase/MyDb.dart';
import '../Widgets/desktopDrawer.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';

class BuyWaterUnitsScreenDesktop extends StatefulWidget {
  @override
  BuyWaterUnitsScreenDesktopState createState() =>
      BuyWaterUnitsScreenDesktopState();
}

class BuyWaterUnitsScreenDesktopState
    extends State<BuyWaterUnitsScreenDesktop> {
  String selectedBiller = "Select Biller",
      selectedMeterType = "Select Meter Type",
      billerName = "";

  TextEditingController meterNoTC = TextEditingController(),
      mobileNumberTC = TextEditingController(),
      amountTC = TextEditingController();

  @override
  void initState() {
    MyDb.initializePaystackPlugin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbarColor,
          elevation: 0,
          iconTheme: IconThemeData(color: primaryColor),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset("images/logo.png", fit: BoxFit.contain),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                /// First column

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.grey,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent)),
                      child: Container(
                        width: 300,
                        child: DesktopDrawer.drawerDetails(
                            context, "Buy Water Units"),
                      ),
                    )),

                /// Second Column
                Expanded(
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/bg1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text("Buy Water unit",
                                        style: MyTextStyles().title),
                                    SizedBox(height: 10),
                                    MyDivider(),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              Constants.topMargin(12),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: EdgeInsets.only(right: desktopRightMargin),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey, // red as border color
                                    ),
                                  ),
                                  child:DropdownButtonHideUnderline(
                                      child:  DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedBiller,
                                      hint: Text(
                                        "Select Biller",
                                      ),
                                      items: waterBillers.map((String valueItem) {
                                        return DropdownMenuItem<String>(
                                          value: valueItem,
                                          child: Text(
                                            valueItem,
                                            textAlign: TextAlign.left,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                       setState(() {
                                         selectedBiller = val!;
                                         setBillerName(
                                             selectedBiller, selectedMeterType);
                                       });
                                      }))),
                              Constants.topMargin(10),
                              Container(
                                  margin: EdgeInsets.only(right: desktopRightMargin),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors
                                                    .grey, // red as border color
                                              ),
                                            ),
                                            child:DropdownButtonHideUnderline(
                                                child:  DropdownButton<String>(
                                                isExpanded: true,
                                                value: selectedMeterType,
                                                hint: Text(
                                                  "Select Meter Type",
                                                ),
                                                items: meterTypes
                                                    .map((String valueItem) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: valueItem,
                                                    child: Text(
                                                      valueItem,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                setState(() {
                                                  selectedMeterType = val!;
                                                  setBillerName(selectedBiller,
                                                      selectedMeterType);
                                                });
                                                }))),
                                      ),
                                      Constants.leftMargin(10),
                                      Expanded(
                                          child: TextFormField(
                                        controller: meterNoTC,
                                        cursorColor: primaryColor,
                                        decoration: InputDecoration(
                                            hintText: "Meter  Number",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: primaryColor))),
                                      ))
                                    ],
                                  )),
                              Constants.topMargin(10),
                              Container(
                                  margin: EdgeInsets.only(right: desktopRightMargin),
                                  child: TextFormField(
                                    controller: mobileNumberTC,
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: "Mobile Number",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                                color: primaryColor))),
                                  )),
                              Constants.topMargin(10),
                              Container(
                                  margin: EdgeInsets.only(right: desktopRightMargin),
                                  child: TextFormField(
                                    controller: amountTC,
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: "Amount",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                                color: primaryColor))),
                                  )),
                              Constants.topMargin(10),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: EdgeInsets.only(right: desktopRightMargin),
                                    width: 280,
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (selectedBiller == "Select Biller") {
                                          Constants.showToast(
                                              msg: "Select your biller",
                                              timeInSecForIosWeb: 3);
                                        } else if (selectedMeterType ==
                                            "Select Meter Type") {
                                          Constants.showToast(
                                              msg: "Select your meter type",
                                              timeInSecForIosWeb: 3);
                                        } else if (meterNoTC.text.isEmpty ||
                                            mobileNumberTC.text.isEmpty ||
                                            amountTC.text.isEmpty) {
                                          Constants.showToast(
                                              msg:
                                                  "One or more fields are empty",
                                              timeInSecForIosWeb: 3);
                                        } else {
                                          MyDialogs.showSummaryDialog(
                                              context: context,
                                              transactionType: "Water",
                                              screenType: "Desktop",
                                              dialogTitle: "Confirm Unit Topup",
                                              dialogDescription:
                                                  "You're about to top up your unit for $selectedBiller.\n\n"
                                                  "SUMMARY\n"
                                                  "Meter No: ${meterNoTC.text}\n"
                                                  "Type: $selectedMeterType\n"
                                                  "Amount: ₦${amountTC.text}\n\n"
                                                      "NOTE: BY CLICKING ON THE 'CONFIRM' BUTTON, YOU ACKNOWLEDGE THAT THE INFORMATION PROVIDED ABOVE ARE CORRECT (PLEASE VERIFY YOUR METER NUMBER AND AMOUNT BEFORE PROCEEDING)\n\n"
                                                      "Are you sure you want to proceed?",
                                              meterNo: meterNoTC.text,
                                              meterType: selectedMeterType.toLowerCase(),
                                              amount: int.parse(amountTC.text),
                                              fullName:
                                                  await Constants.getFullName(),
                                              email: await Constants.getEmail(),
                                              mobileNumber: mobileNumberTC.text,
                                              date: Constants.getCurrentDate(),
                                              time: Constants.getCurrentTime(),
                                              biller: billerName,
                                              reference: DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString());
                                        }
                                      },
                                      child: Text("Continue"),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  primaryColor),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)))),
                                    ),
                                  ))
                            ],
                          ))),
                )
              ],
            )));
  }

  void setBillerName(String selectedBiller, String selectedMeterType) {
    if (selectedBiller != "Select Biller" &&
        selectedMeterType != "Select Meter Type") {
      /// EKEDC
      if (selectedBiller == "Eco-Electricity (EKEDC)" &&
          selectedMeterType == "Prepaid") {
        setState(() {
          billerName = "EKEDC PREPAID TOPUP";
        });
      } else if (selectedBiller == "Eco-Electricity (EKEDC)" &&
          selectedMeterType == "Postpaid") {
        setState(() {
          billerName = "EKEDC POSTPAID TOPUP";
        });
      }

      /// IKEDC
      if (selectedBiller == "Ikeja-Electricity (IKEDC)" &&
          selectedMeterType == "Prepaid") {
        setState(() {
          billerName = "IKEDC  PREPAID";
        });
      } else if (selectedBiller == "Ikeja-Electricity (IKEDC)" &&
          selectedMeterType == "Postpaid") {
        setState(() {
          billerName = "IKEDC  POSTPAID";
        });
      }

      /// Ibadan Disco
      if (selectedBiller == "Ibadan-Electricity (IBEDC)" &&
          selectedMeterType == "Prepaid") {
        setState(() {
          billerName = "IBADAN DISCO ELECTRICITY PREPAID";
        });
      } else if (selectedBiller == "Ibadan-Electricity (IBEDC)" &&
          selectedMeterType == "Postpaid") {
        setState(() {
          billerName = "IBADAN DISCO ELECTRICITY POSTPAID";
        });
      }

      /// Enugu Disco
      if (selectedBiller == "Enugu Disco Electricity" &&
          selectedMeterType == "Prepaid") {
        setState(() {
          billerName = "ENUGU DISCO ELECTRIC BILLS PREPAID TOPUP";
        });
      } else if (selectedBiller == "Enugu Disco Electricity" &&
          selectedMeterType == "Postpaid") {
        setState(() {
          billerName = "ENUGU DISCO ELECTRIC BILLS POSTPAID TOPUP";
        });
      }
    }

    /// Portharcout Disco
    if (selectedBiller == "Portharcourt-Electricity (PHED)" &&
        selectedMeterType == "Prepaid") {
      setState(() {
        billerName = "PHC DISCO POSTPAID TOPUP"; // No prepaid available
      });
    } else if (selectedBiller == "Portharcourt-Electricity (PHED)" &&
        selectedMeterType == "Postpaid") {
      setState(() {
        billerName = "PHC DISCO POSTPAID TOPUP";
      });
    }

    /// Benin Disco
    if (selectedBiller == "Benin Disco" && selectedMeterType == "Prepaid") {
      setState(() {
        billerName = "BENIN DISCO PREPAID TOPUP";
      });
    } else if (selectedBiller == "Benin Disco" &&
        selectedMeterType == "Postpaid") {
      setState(() {
        billerName = "BENIN DISCO POSTPAID TOPUP";
      });
    }

    /// Yola Disco
    if (selectedBiller == "Yola Disco" && selectedMeterType == "Prepaid") {
      setState(() {
        billerName = "YOLA DISCO TOPUP";
      });
    } else if (selectedBiller == "Yola Disco" &&
        selectedMeterType == "Postpaid") {
      setState(() {
        billerName = "YOLA DISCO TOPUP";
      });
    }
  }
}
