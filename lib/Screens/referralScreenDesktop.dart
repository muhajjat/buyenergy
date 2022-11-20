import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../Models/referral.dart';
import '../MyDatabase/MySharedPreferences.dart';
import '../Widgets/desktopDrawer.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';
import '../enpoints.dart';

class ReferralScreenDesktop extends StatefulWidget {
  @override
  ReferralScreenDesktopState createState() => ReferralScreenDesktopState();
}

class ReferralScreenDesktopState extends State<ReferralScreenDesktop> {
  List referralList = [];

  bool noDataTextVisibility = false, loaderVisibility = true;

  Future<List<Referrals>> fetchAllReferrals() async {
    // Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    String? email = await MySharedPreferences.getString(key: "email");
    var response = await http.get(
      Uri.parse(
        referralsEndpoint + email!,
      ),
    );

    var responseJson = json.decode(response.body);
    setState(() {
      referralList = responseJson["user_Referrals"] as List;
    });

    return referralList.map((data) => Referrals.fromJson(data)).toList();
  }

  showDelayForFetchingList() {
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        noDataTextVisibility = true;
        loaderVisibility = false;
      });
    });
  }

  @override
  void initState() {
    fetchAllReferrals();
    showDelayForFetchingList();
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
                            context, "Referral & Reward"),
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
                          child: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text("Referrals",
                                        style: MyTextStyles().title),
                                    SizedBox(height: 10),
                                    MyDivider(),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              Constants.topMargin(12),
                              Container(
                                  margin: EdgeInsets.only(right: desktopRightMargin),
                                  child: referralList.isEmpty
                                      ? Column(
                                          children: [
                                            Visibility(
                                                visible: noDataTextVisibility,
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 200),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          "images/referral.png",
                                                          width: 90,
                                                          height: 90,
                                                        ),
                                                        Constants.topMargin(12),
                                                        const Text(
                                                          "No referrals available to show",
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      ],
                                                    ))),
                                            Visibility(
                                                visible: loaderVisibility,
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 200),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: primaryColor,
                                                    )))
                                          ],
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemCount: referralList.length,
                                          //   reverse: true,
                                          itemBuilder: (((context, index) {
                                            return referralUI(
                                              referralList[index]["refID"],
                                              referralList[index]["refEmail"],
                                              referralList[index]["userEmail"],
                                              referralList[index]["amount"],
                                              referralList[index]["status"],
                                              referralList[index]
                                                  ["dateCreated"],
                                            );
                                          })),
                                        ))
                            ],
                          )))),
                )
              ],
            )));
  }

  Widget referralUI(
      String refID, refEmail, userEmail, amount, status, dateCreated) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "images/referral.png",
                width: 30,
                height: 30,
                color: primaryColor,
              ),
              Constants.rightMargin(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ref Email: $userEmail",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Constants.topMargin(6),
                  Text("Bonus: ₦${numberFormatter.format(int.parse(amount))}"),
                  Constants.topMargin(6),
                  Text("Date: $dateCreated"),
                  // Constants.topMargin(6),
                  //  Text("Satus: " + status == "0" ? "Pending" : "CLAIMED"),
                  Constants.topMargin(9),
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(status == "0" ? "Pending" : "CLAIMED"),
          ),
          const Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
