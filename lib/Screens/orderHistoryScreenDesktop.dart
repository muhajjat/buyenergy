import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../Data/companyDetails.dart';
import '../Models/ModelTransactionList.dart';
import '../MyDatabase/MySharedPreferences.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';
import '../constants.dart';
import '../Widgets/desktopDrawer.dart';
import '../enpoints.dart';

class OrderHistoryScreenDesktop extends StatefulWidget {
  @override
  OrderHistoryScreenDesktopState createState() =>
      OrderHistoryScreenDesktopState();
}

class OrderHistoryScreenDesktopState extends State<OrderHistoryScreenDesktop> {
  List transactionsList = [], sortList = [];

  bool noDataTextVisibility = false, loaderVisibility = true;

  Future<List<ModelTransactionList>> fetchAllTransactions() async {
    // Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    String? email = await MySharedPreferences.getString(key: "email");
    var response = await http.get(
      Uri.parse(
        fetchTransactionsEndpoint + email!,
      ),
    );

    var responseJson = json.decode(response.body);
    setState(() {
      transactionsList = responseJson["user_txn"] as List;
      sortList = transactionsList.reversed.toList();
      sortList = sortList.take(10).toList();
    });

    return sortList.map((data) => ModelTransactionList.fromJson(data)).toList();
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
    fetchAllTransactions();
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
                            context, "Order History"),
                      ),
                    )),

                /// Second Column

                Expanded(
                  child:  Container(
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
                          child: SingleChildScrollView(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text("Order History",
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
                                  child: sortList.isEmpty
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
                                                          "images/statement.png",
                                                          width: 90,
                                                          height: 90,
                                                        ),
                                                        Constants.topMargin(12),
                                                        const Text(
                                                          "No recent transaction history to show",
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      ],
                                                    ))),
                                            Visibility(
                                                visible: loaderVisibility,
                                                child:Center(child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 200),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: primaryColor,
                                                    ))))
                                          ],
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemCount: sortList.length,
                                          //   reverse: true,
                                          itemBuilder: (((context, index) {
                                            return orderHistoryUI(
                                                sortList[index]
                                                    ["transactionType"],
                                                sortList[index]["email"],
                                                sortList[index]["fullName"],
                                                sortList[index]["date"],
                                                sortList[index]["time"],
                                                sortList[index]["meterNumber"],
                                                sortList[index]["amount"],
                                                sortList[index]["type"],
                                                sortList[index]["reference"],
                                                sortList[index]["billerName"],
                                                sortList[index]["token"]);
                                          })),
                                        ))
                            ],
                          )))),
                )
              ],
            )));
  }

  Widget orderHistoryUI(String transactionType, email, fullName, date, time,
      meterNumber, amount, type, reference, billerName, token) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "images/${transactionType.toLowerCase()}.png",
                width: 30,
                height: 30,
                color: primaryColor,
              ),
              Constants.rightMargin(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer: $meterNumber",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Constants.topMargin(6),
                  Text("${transactionType.toUpperCase()}"),
                  Constants.topMargin(6),
                  Text("Amount: ₦${numberFormatter.format(int.parse(amount))}"),
                  Constants.topMargin(6),
                  Text("Date & Time: $date at $time"),
                  Constants.topMargin(6),
                  Text("Token: $token"),
                  Constants.topMargin(9),
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text("Reference No: $reference"),
          ),
          const Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
