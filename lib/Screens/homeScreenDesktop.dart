// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:buy_energy/Widgets/desktopDrawer.dart';
import 'package:buy_energy/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../Models/ModelTransactionList.dart';
import '../Models/transactionSummary.dart';
import '../Models/user.dart';
import '../MyDatabase/MyDb.dart';
import '../MyDatabase/MySharedPreferences.dart';
import '../Widgets/myDialogs.dart';
import '../enpoints.dart';
import 'MainScreen/chargeCardScreen.dart';

class HomeScreenDesktop extends StatefulWidget {
  const HomeScreenDesktop({Key? key}) : super(key: key);

  @override
  State<HomeScreenDesktop> createState() => HomeScreenDesktopState();
}

class HomeScreenDesktopState extends State<HomeScreenDesktop> {
  static late Future<User>? futureUser;
  static late Future<TransactionSummary>? futureSummary;
  List transactionsList = [], sortList = [];

  bool noDataTextVisibility = false, loaderVisibility = true;

  static TextEditingController walletAmountTC = TextEditingController();

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
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        noDataTextVisibility = true;
        loaderVisibility = false;
      });
    });
  }

  static initializeFutureUsers() {
    futureUser = MyDb.fetchUserDetails();
  }

  static initializeFutureSummary() {
    futureSummary = MyDb.fetchSummary();
  }

  @override
  void initState() {
    MyDb.initializePaystackPlugin();
    MyDb.updateUserDetailsOnSharedPreference();
    if (mounted) {
      setState(() {
        initializeFutureUsers();
        initializeFutureSummary();
      });
    }
   fetchAllTransactions();
    showDelayForFetchingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("Hi, ${snapshot.data!.firstName}");
              } else {
                return Row(
                  children: [
                    const Text("Fetching data..."),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: 20,
                      height: 20,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  ],
                );
              }
            }),
        centerTitle: false,
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              MyDialogs.showLogoutDialog(context);
            },
            child: Center(
              child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        "Logout".toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        "images/logout.png",
                        width: 25,
                        height: 25,
                        color: Colors.white,
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// First column

            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.grey,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  child: Container(
                    width: 300,
                    child: DesktopDrawer.drawerDetails(context, "Dashboard"),
                  ),
                )),

            /// Second Column
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // youtube video
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //  aspectRatio: 16 / 5,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.deepPurpleAccent,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                        ),
                        child: Container(
                            child: SingleChildScrollView(
                                child: FutureBuilder<TransactionSummary>(
                          future: futureSummary,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return
                                showSummaryHeader(
                                  snapshot: snapshot,
                                  totalAmountSpent:
                                      snapshot.data!.totalAmountSpent,
                                  onElectricity:
                                  snapshot.data!.onElectricity,
                                  onWater: "0",
                                  //snapshot.data!.onWater,
                                  onSolar: "0",
                                 // snapshot.data!.onSolar
                                );
                            } else {
                              return showSummaryHeader(
                                  snapshot: snapshot,
                                  totalAmountSpent: "0",
                                  onElectricity: "0",
                                  onWater: "0",
                                  onSolar: "0");
                            }
                          },
                        ))),
                      ),
                    ),
                  ),

                  Constants.topMargin(20),
                  const Text(
                    "Transactions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),

                  Constants.topMargin(12),
                  sortList.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                                visible: noDataTextVisibility,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 200),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "images/statement.png",
                                          width: 90,
                                          height: 90,
                                        ),
                                        Constants.topMargin(12),
                                        const Text(
                                          "No recent transaction history to show",
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ))),
                            Visibility(
                                visible: loaderVisibility,
                                child: Center(
                                    child: Container(
                                        margin: const EdgeInsets.only(top: 200),
                                        child: const CircularProgressIndicator(
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
                            return transactionsUI(
                                sortList[index]["transactionType"],
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
                        )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget transactionsUI(String transactionType, email, fullName, date, time,
      meterNumber, amount, type, reference, billerName, token) {
    return Container(
      margin: const EdgeInsets.only(top: 12, right: desktopRightMargin),
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

  static showEnergyWalletBottomDialog(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.only(left: 180, right: 180),
        child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                    child: Wrap(
                  children: [
                    Center(
                        child: Text(
                      "My Energy Wallet".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                    Constants.topMargin(4),
                    const Divider(
                      thickness: 2,
                    ),
                    const Center(
                        child: const Text(
                      "Available Balance",
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    )),
                    Constants.topMargin(4),
                    Center(
                        child: Text(
                      "₦${numberFormatter.format(int.parse(snapshot.data!.walletAmount))}",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )),
                    Constants.topMargin(kIsWeb ? 0 : 12),
                    Visibility(
                        visible: kIsWeb ? false : true,
                        child:  TextFormField(
                      cursorColor: primaryColor,
                      controller: walletAmountTC,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Amount (Ex: ₦2,000)",
                          labelText: "Enter amount here",
                          labelStyle: TextStyle(color: primaryColor),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor))),
                    )),
                    Constants.topMargin(kIsWeb ? 0 : 10),
                    Visibility(
                        visible: kIsWeb ? false : true,
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (walletAmountTC.text.isEmpty) {
                                Constants.showToast(
                                    msg: "Please enter amount to proceed",
                                    timeInSecForIosWeb: 3);
                              } else {
                                //Navigator.pop(context);

                                if (!kIsWeb) {
                                  String? email =
                                      await MySharedPreferences.getString(
                                          key: "email");
                                  MyDb.fundEnergyWallet(
                                    context: context,
                                    email: email!,
                                    walletAmount:
                                        int.parse(walletAmountTC.text),
                                    screenType: "Desktop",
                                  );
                                } else {
                                  String? email =
                                      await MySharedPreferences.getString(
                                          key: "email");

                                  Constants.goToNewPage(
                                      ChargeCardScreen(
                                          walletAmountTC.text, email!),
                                      context);
                                }

                                walletAmountTC.clear();
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryColor)),
                            child: const Text("Fund Wallet"),
                          ),
                        )),
                    Constants.topMargin(10)
                  ],
                ));
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Fetching data..."),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: 20,
                      height: 20,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget showSummaryHeader(
      {required AsyncSnapshot snapshot,
      required totalAmountSpent,
      required onElectricity,
      required onWater,
      required onSolar}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Total Amount Spent",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Constants.topMargin(5),
        Text(
          totalAmountSpent != null
              ? "₦${numberFormatter.format(int.parse(totalAmountSpent))}"
              : "₦0.00",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Constants.topMargin(50),
        IntrinsicHeight(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  "On Electricity",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Constants.topMargin(5),
                Text(
                  onElectricity != null
                      ? "₦${numberFormatter.format(int.parse(onElectricity))}"
                      : "₦0.00",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const VerticalDivider(
              color: Colors.white,
            ),
            Column(
              children: [
                const Text(
                  "On Water",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Constants.topMargin(5),
                Text(
                  onWater != null
                      ? "₦${numberFormatter.format(int.parse(onWater))}"
                      : "₦0.00",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const VerticalDivider(
              color: Colors.white,
            ),
            Column(
              children: [
                const Text(
                  "On Solar",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Constants.topMargin(5),
                Text(
                  onSolar != null
                      ? "₦${numberFormatter.format(int.parse(onSolar))}"
                      : "₦0.00",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        )),
        Constants.topMargin(30),
        IntrinsicHeight(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
              children: [
                const Text(
                  "On EV",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Constants.topMargin(5),
                Text(
                  // onEV != null
                  //     ? "₦${numberFormatter.format(int.parse(onElectricity))}"
                  //     :
                  "₦0.00",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
            const VerticalDivider(
              color: Colors.white,
            ),
            Expanded(
                child: Column(
              children: [
                const Text(
                  "On Gas",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Constants.topMargin(5),
                Text(
                  // onGas != null
                  //     ? "₦${numberFormatter.format(int.parse(onWater))}"
                  //     :
                  "₦0.00",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
            const VerticalDivider(
              color: Colors.white,
            ),
            Expanded(
                child: Column(
              children: [
                const Text(
                  "Energy Consumed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Constants.topMargin(5),
                Text(
                  "Kwh0",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ],
            ))
          ],
        ))
      ],
    );
  }
}
