import 'dart:convert';

import 'package:buy_energy/Data/billers.dart';
import 'package:buy_energy/MyDatabase/MyDb.dart';
import 'package:buy_energy/Widgets/myDialogs.dart';
import 'package:buy_energy/enpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';

class DataPurchaseScreenMobile extends StatefulWidget {
  @override
  DataPurchaseScreenMobileState createState() =>
      DataPurchaseScreenMobileState();
}

class DataPurchaseScreenMobileState extends State<DataPurchaseScreenMobile> {
  String selectedNetwork = "Select Network",
      billerName = "",
      planCodeValue = "",
      selectedPlan = "",
      planAmount = "";

  TextEditingController mobileNumberTC = TextEditingController();

  List dataPlansList = [];

  fetchDataPlans(String network) async {
    var response = await http.post(
        Uri.parse(
          dataLookupEndpoint,
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $payscribeAuthorizationKey',
        },
        body: json.encode({"network": network}));

    if (response.statusCode == 200) {
      Navigator.pop(context);
    setState(() {
      var decoded = json.decode(response.body);

      dataPlansList = decoded["message"]["details"];

      dataPlansList.map((details) {
        setState(() {
          dataPlansList = details["plans"];
        });
      }).toList();
    });

       } else {
      Navigator.pop(context);

      Constants.showToast(
          msg: "ERROR: ${response.statusCode}", timeInSecForIosWeb: 3);
    }
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
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              margin: const EdgeInsets.all(12),
              child: ListView(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text("Data Bundle", style: MyTextStyles().title),
                        const SizedBox(height: 10),
                        MyDivider(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Constants.topMargin(12),
                  TextFormField(
                    controller: mobileNumberTC,
                    cursorColor: primaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Mobile Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: primaryColor))),
                  ),
                  Constants.topMargin(10),
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
                              value: selectedNetwork,
                              hint: const Text(
                                "Select Network",
                              ),
                              items: networks.map((String valueItem) {
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
                                  selectedNetwork = val!;

                                  Constants.showLoader(context,
                                      "Fetching $selectedNetwork Data Plans");

                                  fetchDataPlans(
                                      selectedNetwork.toLowerCase());
                                });
                              }))),
                  Constants.topMargin(10),
                  dataPlansList.isEmpty
                      ? Text("")
                      : GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: dataPlansList.length,
                          itemBuilder: (context, index) {
                            return dataPlansUI(
                              dataPlansList[index]["plan_code"],
                              dataPlansList[index]["name"],
                              dataPlansList[index]["amount"],
                            );
                          },
                        ),
                  Constants.topMargin(10),
                  Container(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedNetwork == "Select Network") {
                          Constants.showToast(
                              msg: "Select a network to continue",
                              timeInSecForIosWeb: 3);
                        } else if (mobileNumberTC.text.isEmpty) {
                          Constants.showToast(
                              msg: "One or more fields are empty",
                              timeInSecForIosWeb: 3);
                        } else if (selectedPlan == "") {
                          Constants.showToast(
                              msg: "Please select a plan to proceed",
                              timeInSecForIosWeb: 3);
                        } else {
                          MyDialogs.showPaymentMethodDialog(
                              context: context,
                              transactionType: "Data",
                              dialogTitle: "",
                              screenType: "Mobile",
                              dialogDescription: "",
                              meterNo: "",
                              meterType: "",
                              amount: int.parse(planAmount),
                              plan: planCodeValue,
                              fullName: await Constants.getFullName(),
                              email: await Constants.getEmail(),
                              date: Constants.getCurrentDate(),
                              time: Constants.getCurrentTime(),
                              biller: selectedNetwork,
                              mobileNumber: mobileNumberTC.text,
                              reference: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString());
                        }
                      },
                      child: const Text("Continue"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)))),
                    ),
                  )
                ],
              ))),
    );
  }

  Widget dataPlansUI(String planCode, String name, String amount) {
    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          //Constants.showToast(msg: name, timeInSecForIosWeb: 3);

          setState(() {
            planCodeValue = planCode;
            selectedPlan = name;
            planAmount = amount;
          });
        },
        child: Card(
            elevation: 4,
            shadowColor: primaryColor,
            color: (selectedPlan == name) ? primaryColor : null,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent)),
            child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: (selectedPlan == name) ? Colors.white : null,
                        )),
                  ),
                  Constants.topMargin(7),
                  Text(
                    amount == null
                        ? ""
                        : "₦${numberFormatter.format(int.parse(amount))}",
                    style: TextStyle(
                      color: selectedPlan == name ? Colors.white : null,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
