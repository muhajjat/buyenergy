import 'package:buy_energy/Data/billers.dart';
import 'package:buy_energy/MyDatabase/MyDb.dart';
import 'package:buy_energy/Widgets/myDialogs.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';

class AirtimePurchaseScreenMobile extends StatefulWidget {
  @override
  AirtimePurchaseScreenMobileState createState() =>
      AirtimePurchaseScreenMobileState();
}

class AirtimePurchaseScreenMobileState
    extends State<AirtimePurchaseScreenMobile> {
  String selectedNetwork = "Select Network",
      selectedMeterType = "Select Meter Type",
      billerName = "";

  TextEditingController mobileNumberTC = TextEditingController(),
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
              margin: EdgeInsets.all(12),
              child: ListView(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text("Top up", style: MyTextStyles().title),
                        SizedBox(height: 10),
                        MyDivider(),
                        SizedBox(height: 10),
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
                              value: selectedNetwork,
                              hint: Text(
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
                                });
                              }))),
                  Constants.topMargin(10),

                  Constants.topMargin(10),
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
                            borderSide: BorderSide(color: primaryColor))),
                  ),
                  Constants.topMargin(10),
                  TextFormField(
                    controller: amountTC,
                    cursorColor: primaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Amount",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryColor))),
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
                        } else if (mobileNumberTC.text.isEmpty ||
                            amountTC.text.isEmpty) {
                          Constants.showToast(
                              msg: "One or more fields are empty",
                              timeInSecForIosWeb: 3);
                        } else if (int.parse(amountTC.text) < 50) {
                          Constants.showToast(
                              msg: "Amount cannot be less than N50",
                              timeInSecForIosWeb: 3);
                          // MyDialogs.showInfoDialog(
                          //     context,
                          //     "AMOUNT CANNOT BE LESS THAN AND GREATER N50",
                          //     "For the purpose of testing, please top up only N50.");
                        } else {

                          MyDialogs.showPaymentMethodDialog(
                              context: context,
                              transactionType: "Airtime",
                              dialogTitle: "",
                              screenType: "Mobile",
                              dialogDescription: "",
                              meterNo: "",
                              meterType: "",
                              amount: int.parse(amountTC.text),
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
                      child: Text("Continue"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)))),
                    ),
                  )
                ],
              )
          )
      ),
    );
  }
}
