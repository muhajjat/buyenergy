import 'package:buy_energy/Data/billers.dart';
import 'package:buy_energy/Widgets/myDialogs.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../MyDatabase/MyDb.dart';
import '../Widgets/desktopDrawer.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';

class AirtimePurchaseScreenDesktop extends StatefulWidget {
  @override
  AirtimePurchaseScreenDesktopState createState() =>
      AirtimePurchaseScreenDesktopState();
}

class AirtimePurchaseScreenDesktopState
    extends State<AirtimePurchaseScreenDesktop> {
  String selectedNetwork = "Select Network",
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
                        child: DesktopDrawer.drawerDetails(context, "Airtime"),
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
                                    Text("Top up", style: MyTextStyles().title),
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
                                          value: selectedNetwork,
                                          hint: const Text(
                                            "Select Network",
                                          ),
                                          items:
                                              networks.map((String valueItem) {
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
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: primaryColor))),
                              ),
                              Constants.topMargin(10),
                              TextFormField(
                                controller: amountTC,
                                cursorColor: primaryColor,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Amount",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: primaryColor))),
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
                                          fullName:
                                              await Constants.getFullName(),
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

  void setBillerName(String selectedBiller, String selectedMeterType) {
    if (selectedBiller != "Select Biller" &&
        selectedMeterType != "Select Meter Type") {
      /// AEDC
      if (selectedBiller == "Abuja Electricity Distribution Company (AEDC)" &&
          selectedMeterType == "Prepaid") {
        setState(() {
          billerName = "aedc";
        });
      } else if (selectedBiller ==
              "Abuja Electricity Distribution Company (AEDC)" &&
          selectedMeterType == "Postpaid") {
        setState(() {
          billerName = "aedc";
        });
      }

      /// EKEDC
      if (selectedBiller == "Eco-Electricity (EKEDC)" &&
          selectedMeterType == "Prepaid") {
        setState(() {
          billerName = "ekedc";
        });
      } else if (selectedBiller == "Eco-Electricity (EKEDC)" &&
          selectedMeterType == "Postpaid") {
        setState(() {
          billerName = "ekedc";
        });
      }

      /// IKEDC
      if (selectedBiller == "Ikeja-Electricity (IKEDC)" &&
          selectedMeterType == "Prepaid") {
        setState(() {
          billerName = "ikedc";
        });
      } else if (selectedBiller == "Ikeja-Electricity (IKEDC)" &&
          selectedMeterType == "Postpaid") {
        setState(() {
          billerName = "ikedc";
        });
      }

      /// Ibadan Disco
      if (selectedBiller == "Ibadan-Electricity (IBEDC)" &&
          selectedMeterType == "Prepaid") {
        setState(() {
          billerName = "ibedc";
        });
      } else if (selectedBiller == "Ibadan-Electricity (IBEDC)" &&
          selectedMeterType == "Postpaid") {
        setState(() {
          billerName = "ibedc";
        });
      }

      /// Enugu Disco
      if (selectedBiller == "Enugu Disco Electricity" &&
          selectedMeterType == "Prepaid") {
        setState(() {
          billerName = "eedc";
        });
      } else if (selectedBiller == "Enugu Disco Electricity" &&
          selectedMeterType == "Postpaid") {
        setState(() {
          billerName = "eedc";
        });
      }
    }

    /// Portharcout Disco
    if (selectedBiller == "Portharcourt-Electricity (PHED)" &&
        selectedMeterType == "Prepaid") {
      setState(() {
        billerName = "phedc"; // No prepaid available
      });
    } else if (selectedBiller == "Portharcourt-Electricity (PHED)" &&
        selectedMeterType == "Postpaid") {
      setState(() {
        billerName = "phedc";
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

    /// Kaduna Electricity
    if (selectedBiller == "Kaduna-Electricity (KAEDCO)" &&
        selectedMeterType == "Prepaid") {
      setState(() {
        billerName = "kedco";
      });
    } else if (selectedBiller == "Benin Disco" &&
        selectedMeterType == "Postpaid") {
      setState(() {
        billerName = "kedco";
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

  /// Set biller name for Flutter wave
// void setBillerName(String selectedBiller, String selectedMeterType) {
//   if (selectedBiller != "Select Biller" &&
//       selectedMeterType != "Select Meter Type") {
//     /// EKEDC
//     if (selectedBiller == "Eco-Electricity (EKEDC)" &&
//         selectedMeterType == "Prepaid") {
//       setState(() {
//         billerName = "EKEDC PREPAID TOPUP";
//       });
//     } else if (selectedBiller == "Eco-Electricity (EKEDC)" &&
//         selectedMeterType == "Postpaid") {
//       setState(() {
//         billerName = "EKEDC POSTPAID TOPUP";
//       });
//     }
//
//     /// IKEDC
//     if (selectedBiller == "Ikeja-Electricity (IKEDC)" &&
//         selectedMeterType == "Prepaid") {
//       setState(() {
//         billerName = "IKEDC  PREPAID";
//       });
//     } else if (selectedBiller == "Ikeja-Electricity (IKEDC)" &&
//         selectedMeterType == "Postpaid") {
//       setState(() {
//         billerName = "IKEDC  POSTPAID";
//       });
//     }
//
//     /// Ibadan Disco
//     if (selectedBiller == "Ibadan-Electricity (IBEDC)" &&
//         selectedMeterType == "Prepaid") {
//       setState(() {
//         billerName = "IBADAN DISCO ELECTRICITY PREPAID";
//       });
//     } else if (selectedBiller == "Ibadan-Electricity (IBEDC)" &&
//         selectedMeterType == "Postpaid") {
//       setState(() {
//         billerName = "IBADAN DISCO ELECTRICITY POSTPAID";
//       });
//     }
//
//     /// Enugu Disco
//     if (selectedBiller == "Enugu Disco Electricity" &&
//         selectedMeterType == "Prepaid") {
//       setState(() {
//         billerName = "ENUGU DISCO ELECTRIC BILLS PREPAID TOPUP";
//       });
//     } else if (selectedBiller == "Enugu Disco Electricity" &&
//         selectedMeterType == "Postpaid") {
//       setState(() {
//         billerName = "ENUGU DISCO ELECTRIC BILLS POSTPAID TOPUP";
//       });
//     }
//   }
//
//   /// Portharcout Disco
//   if (selectedBiller == "Portharcourt-Electricity (PHED)" &&
//       selectedMeterType == "Prepaid") {
//     setState(() {
//       billerName = "PHC DISCO POSTPAID TOPUP"; // No prepaid available
//     });
//   } else if (selectedBiller == "Portharcourt-Electricity (PHED)" &&
//       selectedMeterType == "Postpaid") {
//     setState(() {
//       billerName = "PHC DISCO POSTPAID TOPUP";
//     });
//   }
//
//   /// Benin Disco
//   if (selectedBiller == "Benin Disco" && selectedMeterType == "Prepaid") {
//     setState(() {
//       billerName = "BENIN DISCO PREPAID TOPUP";
//     });
//   } else if (selectedBiller == "Benin Disco" &&
//       selectedMeterType == "Postpaid") {
//     setState(() {
//       billerName = "BENIN DISCO POSTPAID TOPUP";
//     });
//   }
//
//   /// Yola Disco
//   if (selectedBiller == "Yola Disco" && selectedMeterType == "Prepaid") {
//     setState(() {
//       billerName = "YOLA DISCO TOPUP";
//     });
//   } else if (selectedBiller == "Yola Disco" &&
//       selectedMeterType == "Postpaid") {
//     setState(() {
//       billerName = "YOLA DISCO TOPUP";
//     });
//   }
// }
}
