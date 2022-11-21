import 'dart:convert';

import 'package:buy_energy/Models/ModelTransactionList.dart';
import 'package:buy_energy/MyDatabase/MySharedPreferences.dart';
import 'package:buy_energy/enpoints.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';

class AccountStatementsScreenMobile extends StatefulWidget {
  @override
  AccountStatementsScreenMobileState createState() =>
      AccountStatementsScreenMobileState();
}

class AccountStatementsScreenMobileState
    extends State<AccountStatementsScreenMobile> {
  List transactionsList = [], sortList = [];

  bool noDataTextVisibility = false, loaderVisibility = true;

  late DioCacheManager dioCacheManager;

  Future<List<ModelTransactionList>> fetchAllTransactionsMobile() async {
    // Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    String? email = await MySharedPreferences.getString(key: "email");

    dioCacheManager = DioCacheManager(CacheConfig());

    Options cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    Dio dio = Dio();
    dio.interceptors.add(dioCacheManager.interceptor);
    Response response = await dio.get(fetchTransactionsEndpoint + email!,
        options: cacheOptions);

    setState(() {
      var responseJson = response.data["user_txn"];
      transactionsList = responseJson;
      sortList = transactionsList.reversed.toList();
      sortList = sortList.take(10).toList();
    });

    return sortList.map((data) => ModelTransactionList.fromJson(data)).toList();
  }

  Future<List<ModelTransactionList>> fetchAllTransactionsWeb() async {
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
    kIsWeb ? fetchAllTransactionsWeb() : fetchAllTransactionsMobile();
    showDelayForFetchingList();
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
                        Text("Account Statements", style: MyTextStyles().title),
                        const SizedBox(height: 10),
                        MyDivider(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Constants.topMargin(12),

                  //Lists of transactions here

                  sortList.isEmpty
                      ? Column(
                          children: [
                            Visibility(
                                visible: noDataTextVisibility,
                                child: Container(
                                    margin: EdgeInsets.only(top: 200),
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
                                child: Container(
                                    margin: EdgeInsets.only(top: 200),
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    )))
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: sortList.length,
                          //   reverse: true,
                          itemBuilder: (((context, index) {
                            return accountStatementsUI(
                                sortList[index]["transactionType"],
                                sortList[index]["email"],
                                sortList[index]["fullName"],
                                sortList[index]["date"],
                                sortList[index]["time"],
                                sortList[index]["meterNumber"],
                                sortList[index]["amount"],
                                sortList[index]["type"],
                                sortList[index]["token"],
                                sortList[index]["reference"],
                                sortList[index]["billerName"]);
                          })),
                        )
                ],
              ))),
    );
  }

  Widget accountStatementsUI(String transactionType, email, fullName, date,
      time, meterNumber, amount, type, token, reference, billerName) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(
              //   "images/${transactionType.toLowerCase()}.png",
              //   width: 30,
              //   height: 30,
              //   color: primaryColor,
              // ),
              // Constants.rightMargin(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$meterNumber - $billerName",
                    style: const TextStyle(color: primaryColor, fontSize: 18),
                  ),
                  Constants.topMargin(6),
                  Text("$fullName - $email"),
                  Constants.topMargin(6),
                  Text(
                      "$transactionType - ₦${numberFormatter.format(int.parse(amount))}"),
                  Text("$date at $time"),
                  Constants.topMargin(6),
                  Text("Token: ${token == "" ? "NIL" : token}/Ref: $reference"),
                  Constants.topMargin(9),
                ],
              )
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Text("Reference No: $reference"),
          // ),
          const Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
