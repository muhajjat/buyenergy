import 'dart:convert';

import 'package:buy_energy/Data/billers.dart';
import 'package:buy_energy/Widgets/myDialogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../MyDatabase/MyDb.dart';
import '../Widgets/desktopDrawer.dart';
import '../Widgets/divider.dart';
import '../Widgets/loader.dart';
import '../Widgets/textStyle.dart';
import '../enpoints.dart';

class CableTVScreenDesktop extends StatefulWidget {
  @override
  CableTVScreenDesktopState createState() => CableTVScreenDesktopState();
}

class CableTVScreenDesktopState extends State<CableTVScreenDesktop> {
  String selectedBiller = "Select Biller",
      selectedPlan = "",
      billerName = "",
      productCode = "",
      productToken = "",
      multiChoiceAmount = "";

  TextEditingController mobileNumberTC = TextEditingController(),
      smartCardNumberTC = TextEditingController(),
      amountTC = TextEditingController();

  List cableTVPlansList = [];

  bool amountTCVisibility = false;

  fetchMultichoiceplans(
      {required String biller, required String account}) async {
   // Constants.showLoader(context, "Fetching Plans. Please wait...");
    showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => MyLoader("Fetching Plans. Please wait..."),
    );
    var response = await http.post(
        Uri.parse(
          validateMultichoiceCableTVEndpoint,
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $payscribeAuthorizationKey',
        },
        body: json.encode({"type": biller.toLowerCase(), "account": account}));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      setState(() {
        var decoded = json.decode(response.body);

        productCode = decoded["message"]["details"]["productCode"];
        productToken = decoded["message"]["details"]["productToken"];
        cableTVPlansList = decoded["message"]["details"]["bouquets"];
      });
    } else {
      Navigator.pop(context);
      Constants.showToast(
          msg: "Error Occurred: ${response.statusCode}", timeInSecForIosWeb: 3);
    }

    //  return cableTVPlansList.map((data) => CableTV.fromJson(data)).toList();
  }

  fetchStartimesplans({required String account, required String amount}) async {
  //  Constants.showLoader(context, "Fetching Plans. Please wait...");
    showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => MyLoader("Fetching Plans. Please wait..."),
    );
    var response = await http.post(
        Uri.parse(
          validateStartimesCableTVEndpoint,
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $payscribeAuthorizationKey',
        },
        body: json.encode({"account": account, "amount": amount}));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      setState(() {
        var decoded = json.decode(response.body);

        productCode = decoded["message"]["details"]["productCode"];
        productToken = decoded["message"]["details"]["productToken"];
        cableTVPlansList = decoded["message"]["details"]["bouquets"];
      });
    } else {
      Navigator.pop(context);
      Constants.showToast(
          msg: "Error Occurred: ${response.body}", timeInSecForIosWeb: 3);
    }

    //  return cableTVPlansList.map((data) => CableTV.fromJson(data)).toList();
  }

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
          iconTheme: const IconThemeData(color: primaryColor),
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
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      child: Container(
                        width: 300,
                        child: DesktopDrawer.drawerDetails(context, "Cable TV"),
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
                          margin: const EdgeInsets.only(
                              left: 12,
                              bottom: 12,
                              top: 12,
                              right: desktopRightMargin),
                          child: ListView(
                            //  crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text("Cable TV",
                                        style: MyTextStyles().title),
                                    const SizedBox(height: 10),
                                    MyDivider(),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              Constants.topMargin(12),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey, // red as border color
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: selectedBiller,
                                          hint: const Text(
                                            "Select Biller",
                                          ),
                                          items:
                                              cableTV.map((String valueItem) {
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
                                              selectedPlan = "";
                                              cableTVPlansList.clear();

                                              if (selectedBiller ==
                                                  "Startimes") {
                                                amountTCVisibility = true;
                                              } else {
                                                amountTCVisibility = false;
                                              }
                                            });
                                          }))),
                              Constants.topMargin(10),
                              Constants.topMargin(10),
                              TextFormField(
                                controller: smartCardNumberTC,
                                cursorColor: primaryColor,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Smart Card Number",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: primaryColor))),
                              ),
                              Constants.topMargin(10),
                              TextFormField(
                                controller: mobileNumberTC,
                                cursorColor: primaryColor,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Mobile Number",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: primaryColor))),
                              ),
                              Constants.topMargin(10),
                              Visibility(
                                  visible: amountTCVisibility,
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
                                            borderSide: const BorderSide(
                                                color: primaryColor))),
                                  )),
                              Constants.topMargin(10),
                              cableTVPlansList.isEmpty
                                  ? Center(
                                      child: Text(""),
                                    )
                                  : GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                      ),
                                      itemCount: cableTVPlansList.length,
                                      itemBuilder: (context, index) {
                                        return cableTVPlans(
                                          cableTVPlansList[index]["name"],
                                          cableTVPlansList[index]["amount"],
                                          cableTVPlansList[index]["plan"],
                                        );
                                      },
                                    ),
                              Constants.topMargin(10),
                              Container(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (selectedBiller == "Select Biller") {
                                      Constants.showToast(
                                          msg: "Select a biller to continue",
                                          timeInSecForIosWeb: 3);
                                    } else if (mobileNumberTC.text.isEmpty ||
                                        smartCardNumberTC.text.isEmpty ||
                                        (selectedBiller == "Startimes" &&
                                            amountTC.text.isEmpty)) {
                                      Constants.showToast(
                                          msg: "One or more fields are empty",
                                          timeInSecForIosWeb: 3);
                                    } else if (selectedPlan == "") {
                                      // Constants.showToast(
                                      //     msg: "Please select a plan to continue",
                                      //     timeInSecForIosWeb: 3);

                                      if (selectedBiller != "") {
                                        if (selectedBiller == "Startimes") {
                                          fetchStartimesplans(
                                            account: smartCardNumberTC.text,
                                            amount: amountTC.text,
                                          );
                                        } else {
                                          fetchMultichoiceplans(
                                              biller:
                                                  selectedBiller.toLowerCase(),
                                              account: smartCardNumberTC.text);
                                        }
                                      }
                                    } else {
                                      MyDialogs.showPaymentMethodDialog(
                                          context: context,
                                          transactionType: "Cable TV",
                                          dialogTitle: "",
                                          screenType: "Mobile",
                                          dialogDescription: "",
                                          meterNo: smartCardNumberTC.text,
                                          meterType: "",
                                          plan: selectedPlan,
                                          productCode: productCode,
                                          productToken: productToken,
                                          amount: selectedBiller == "Startimes"
                                              ? int.parse(amountTC.text)
                                              : int.parse(multiChoiceAmount),
                                          fullName:
                                              await Constants.getFullName(),
                                          email: await Constants.getEmail(),
                                          date: Constants.getCurrentDate(),
                                          time: Constants.getCurrentTime(),
                                          biller: selectedBiller,
                                          mobileNumber: mobileNumberTC.text,
                                          reference: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString());
                                    }
                                  },
                                  child: const Text("Continue"),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              primaryColor),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)))),
                                ),
                              )
                            ],
                          ))),
                )
              ],
            )));
  }

  Widget cableTVPlans(String name, String amount, String plan) {
    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          //Constants.showToast(msg: name, timeInSecForIosWeb: 3);

          setState(() {
            if (selectedBiller == "Startimes") {
              selectedPlan = name;
            } else {
              selectedPlan = plan;
              multiChoiceAmount = amount;
            }
          });
        },
        child: Card(
            elevation: 4,
            shadowColor: primaryColor,
            color: (selectedPlan == plan || selectedPlan == name)
                ? primaryColor
                : null,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent)),
            child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: (selectedPlan == "Startimes" ||
                                  selectedPlan == "GoTV")
                              ? 15
                              : 12,
                          color: (selectedPlan == plan || selectedPlan == name)
                              ? Colors.white
                              : null,
                        )),
                  ),
                  Text(
                    amount == null
                        ? ""
                        : "₦${numberFormatter.format(int.parse(amount))}",
                    style: TextStyle(
                      color: selectedPlan == plan ? Colors.white : null,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
