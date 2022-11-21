// ignore_for_file: use_build_context_synchronously

import 'package:buy_energy/Models/bankDetails.dart';
import 'package:buy_energy/Models/user.dart';
import 'package:buy_energy/Screens/MainScreen/accountStatementsScreen.dart';
import 'package:buy_energy/Screens/MainScreen/airtimePurchaseScreen.dart';
import 'package:buy_energy/Screens/MainScreen/buyWaterUnitScreen.dart';
import 'package:buy_energy/Screens/MainScreen/cableTVScreen.dart';
import 'package:buy_energy/Screens/MainScreen/contactUsScreen.dart';
import 'package:buy_energy/Screens/MainScreen/dataPurchaseScreen.dart';
import 'package:buy_energy/Screens/MainScreen/referralScreen.dart';
import 'package:buy_energy/Screens/MainScreen/transactionScreen.dart';
import 'package:buy_energy/Screens/orderHistoryScreenMobile.dart';
import 'package:buy_energy/Screens/qrPaymentScreen.dart';
import 'package:buy_energy/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../Models/transactionSummary.dart';
import '../MyDatabase/MyDb.dart';
import '../MyDatabase/MySharedPreferences.dart';
import '../Widgets/myDialogs.dart';
import 'MainScreen/buyEnergyUnitScreen.dart';
import 'MainScreen/buySolarUnitScreen.dart';
import 'MainScreen/chargeCardScreen.dart';
import 'MainScreen/digitalInvoiceScreen.dart';
import 'MainScreen/faqScreen.dart';
import 'MainScreen/profileScreen.dart';
import 'MainScreen/settingsScreen.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({Key? key}) : super(key: key);

  @override
  State<HomeScreenMobile> createState() => HomeScreenMobileState();
}

class HomeScreenMobileState extends State<HomeScreenMobile> {
  static late Future<User>? futureUser;
  static late Future<TransactionSummary>? futureSummary;
  static late Future<BankDetails>? futureBankDetails;
  Dio dio = Dio();

  TextEditingController walletAmountTC = TextEditingController();
  double walletAmountFocusMargin = 10;

  static initializeFutureBankDetails() {
    futureBankDetails = MyDb.fetchBankDetails();
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
        MyDb.syncBaseUrl();
        initializeFutureUsers();
        initializeFutureSummary();
        initializeFutureBankDetails();
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
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
        actions: const [
          // Container(
          //   margin: const EdgeInsets.all(12),
          //   child: InkWell(
          //     onTap: () {},
          //     child: const Icon(Icons.account_balance_wallet_outlined),
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.all(12),
          //   child: InkWell(
          //     onTap: () {},
          //     child: const Icon(Icons.person_outline_outlined),
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                Constants.topMargin(12),
                Image.asset(
                  "images/logo.png",
                  width: 90,
                  height: 90,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Constants.topMargin(12),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.dashboard_outlined,
                    color: secondaryColor,
                  ),
                  title: const Text(
                    "Dashboard",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: secondaryColor),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Constants.goToNewPage(AirtimePurchaseScreen(), context);
                  },
                  leading: const Icon(Icons.phone_android_outlined,
                 
                  ),
                  title: const Text(
                    "Top up",
                    style: TextStyle(
                      fontSize: 18,
                     
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Constants.goToNewPage(DataPurchaseScreen(), context);
                    // Constants.showToast(msg: "Currently Under Development...", timeInSecForIosWeb: 3);
                  },
                  leading: const Icon(Icons.phonelink_outlined,      ),
                  title: const Text(
                    "Data Bundle",
                    style: TextStyle(
                      fontSize: 18,
                     
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Constants.goToNewPage(CableTVScreen(), context);
                    // Constants.showToast(msg: "Currently Under Development...", timeInSecForIosWeb: 3);
                  },
                  leading: const Icon(Icons.tv_rounded,
                   ),
                  title: const Text(
                    "Cable TV",
                    style: TextStyle(
                      fontSize: 18,
                     
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Constants.goToNewPage(TransactionScreen(), context);
                  },
                  leading: const Icon(Icons.list_outlined,
                   ),
                  title: const Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: 18,
                     
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Constants.goToNewPage(ProfileScreen(), context);
                  },
                  leading: const Icon(Icons.person_outline_outlined,
                  ),
                  title: const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 18,

                    ),
                  ),
                ),

                ListTile(
                  onTap: () {
                    MyDialogs.showInfoDialog(
                        context, "E-Biller".toUpperCase(), "Coming Soon!");
                  },
                  leading: const Icon(Icons.sim_card_outlined,
                  ),
                  title: const Text(
                    "E-Biller",
                    style: TextStyle(
                      fontSize: 18,

                    ),
                  ),
                ),


                ListTile(
                  onTap: () {
                    MyDialogs.showInfoDialog(
                        context, "My Energy Card".toUpperCase(), "Coming Soon!");
                  },
                  leading: const Icon(Icons.credit_card_outlined,
                  ),
                  title: const Text(
                    "My Energy Card",
                    style: TextStyle(
                      fontSize: 18,

                    ),
                  ),
                ),




                ListTile(
                  onTap: () {
                    MyDialogs.showInfoDialog(
                        context, "Chats".toUpperCase(), "Coming Soon!");
                  },
                  leading: const Icon(Icons.chat_sharp,
                   ),
                  title: const Text(
                    "Chats",
                    style: TextStyle(
                      fontSize: 18,
                     
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Constants.goToNewPage(SettingsScreen(), context);
                  },
                  leading: const Icon(Icons.settings_outlined,
                   ),
                  title: const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 18,
                     
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Constants.goToNewPage(FAQScreen(), context);
                  },
                  leading: const Icon(Icons.contact_support_outlined,
                   ),
                  title: const Text(
                    "FAQ",
                    style: TextStyle(
                      fontSize: 18,
                     
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Constants.goToNewPage(ContactUsScreen(), context);
                  },
                  leading: const Icon(Icons.info_outline,
                   ),
                  title: const Text(
                    "Contact Center",
                    style: TextStyle(
                      fontSize: 18,
                     
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    MyDialogs.showLogoutDialog(context);
                  },
                  leading: const Icon(Icons.logout_outlined,
                   ),
                  title: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18,
                     
                    ),
                  ),
                ),
              ],
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  // height: 285,
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
                  child: FutureBuilder<TransactionSummary>(
                    future: futureSummary,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return showSummaryHeader(
                            snapshot: snapshot,
                            totalAmountSpent: snapshot.data!.totalAmountSpent,
                            onElectricity: snapshot.data!.onElectricity,
                            onWater: "0",
                            onSolar:  "0",
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
                  )),
              Constants.topMargin(20),
              showMenuGrids()
            ],
          ),
        ),
      ),
    );
  }

  Widget showMenuGrids() {
    return Column(
      children: [
        row1MenuGrid(),
        Constants.topMargin(20),
        row2MenuGrid(),
        Constants.topMargin(20),
        row3MenuGrid(),
        Constants.topMargin(20),
        row4MenuGrid(),
        Constants.topMargin(20),
        row5MenuGrid()
      ],
    );
  }

  Widget row1MenuGrid() {
    return

        /// Row 1
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        /// Row 1 Item 1
        Expanded(
            child: GestureDetector(
          onTap: () {
            Constants.goToNewPage(const BuyEnergyUnitScreen(), context);
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/electricity.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Buy Energy\nUnits",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),

        /// Row 1 Item 2
        Expanded(
            child: GestureDetector(
          onTap: () {
            Constants.goToNewPage(const BuyWaterUnitScreen(), context);
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/water.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Buy Water\nUnits",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),

        /// Row 1 Item 3
        Expanded(
            child: GestureDetector(
          onTap: () {
            Constants.goToNewPage(const BuySolarUnitScreen(), context);
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/solar.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Solar Recharge\nUnits",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),
      ],
    );
  }

  Widget row2MenuGrid() {
    return

        /// Row 2
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        /// Row 2 Item 1
        Expanded(
            child: GestureDetector(
          onTap: () {
            MyDialogs.showInfoDialog(
                context, "My Home Automation".toUpperCase(), "Coming Soon!");
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/automation.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "My Home\nAutomation",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),

        /// Row 2 Item 2
        Expanded(
            child: GestureDetector(
          onTap: () {
            MyDialogs.showInfoDialog(
                context, "EV Charging".toUpperCase(), "Coming Soon!");
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/charging.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "EV Charging",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),

        /// Row 2 Item 3
        Expanded(
            child: GestureDetector(
          onTap: () async {
            MyDialogs.showInfoDialog(
                context, "Buy Gas Unit".toUpperCase(), "Coming Soon!");
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/gas.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Buy Gas Units",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),
      ],
    );
  }

  Widget row3MenuGrid() {
    return

        /// Row 3
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        /// Row 3 Item 1
        Expanded(
            child: GestureDetector(
          onTap: () {
            MyDialogs.showInfoDialog(
                context, "Eco System".toUpperCase(), "Coming Soon!");
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/ecosystem.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Eco System",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),

        /// Row 2 Item 2
        Expanded(
            child: GestureDetector(
          onTap: () {
            MyDialogs.showInfoDialog(
                context, "Inventory Management".toUpperCase(), "Coming Soon!");
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/inventory.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Inventory\nManagement",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),

        /// Row 2 Item 3
        Expanded(
            child: GestureDetector(
          onTap: () {
            Constants.goToNewPage(OrderHistoryScreenMobile(), context);
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/history.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Order History",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),
      ],
    );
  }

  Widget row4MenuGrid() {
    return

        /// Row 4

        Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        /// Row 4 Item 1
        Expanded(
            child: GestureDetector(
          onTap: () {
            MyDialogs.showInfoDialog(context,
                "Units Consumption Breakdown".toUpperCase(), "Coming Soon!");
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/breakdown.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Units Consumption\nBreakdown",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),

        /// Row 4 Item 2
        Expanded(
            child: GestureDetector(
          onTap: () {
            Constants.goToNewPage(AccountStatementsScreen(), context);
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/statement.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Account Statement",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),

        /// Row 4 Item 3
        Expanded(
            child: GestureDetector(
          onTap: () {
            initializeFutureUsers();
            showEnergyWalletBottomDialog();
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/wallet.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "My Energy\nWallet",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),
      ],
    );
  }

  Widget row5MenuGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        /// Row 5 Item 1
        Expanded(
            child: GestureDetector(
          onTap: () {
            Constants.goToNewPage(ReferralScreen(), context);
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/referral.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Referral & Reward",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),

        Expanded(
            child: GestureDetector(
          onTap: () {
            Constants.goToNewPage(DigitalInvoiceScreen(), context);
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "images/invoice.png",
                  width: 40,
                  height: 40,
                  color: menuIconsColor,
                ),
              ),
              Constants.topMargin(15),
              const Text(
                "Digital Invoice",
                textAlign: TextAlign.center,
              )
            ],
          ),
        )),

        FutureBuilder<BankDetails>(
            future: futureBankDetails,
            builder: (context, snapshot) {
              return Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (!kIsWeb) {
                    if (snapshot.hasData) {
                      Constants.goToNewPage(
                          QRPaymentScreen(
                              snapshot.data!.bankName,
                              snapshot.data!.accountName,
                              snapshot.data!.accountNumber,
                              snapshot.data!.swiftCode),
                          context);
                    } else {
                      Constants.showToast(
                          msg:
                              "Preparing QR Code. Please try again in few seconds",
                          timeInSecForIosWeb: 3);
                    }
                  } else {
                    Constants.showToast(
                        msg:
                            "QR CODE PAYMENT IS NOT AVAILABLE FOR WEB. USE OUR MOBILE APP INSTEAD.",
                        timeInSecForIosWeb: 3);
                  }
                },
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 7), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "images/qr.png",
                        width: 40,
                        height: 40,
                        color: menuIconsColor,
                      ),
                    ),
                    Constants.topMargin(15),
                    const Text(
                      "QR Code Payment",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ));
            }),
      ],
    );
  }

  Widget showSummaryHeader(
      {required AsyncSnapshot<TransactionSummary> snapshot,
      required String totalAmountSpent,
      required String onElectricity,
      required String onWater,
      required String onSolar}) {
    return Column(
      children: [
        const Text(
          "Total Amount Spent",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Constants.topMargin(5),
        Text(
          totalAmountSpent != null
              ? "₦${numberFormatter.format(int.parse(totalAmountSpent))}"
              : "₦0.00",
          style: const TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Constants.topMargin(50),
        IntrinsicHeight(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
              children: [
                const Text(
                  "Electricity",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Constants.topMargin(5),
                Text(
                  onElectricity != null
                      ? "₦${numberFormatter.format(int.parse(onElectricity))}"
                      : "₦0.00",
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
                  "On Water",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Constants.topMargin(5),
                Text(
                  onWater != null
                      ? "₦${numberFormatter.format(int.parse(onWater))}"
                      : "₦0.00",
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
                  "On Solar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Constants.topMargin(5),
                Text(
                  onSolar != null
                      ? "₦${numberFormatter.format(int.parse(onSolar))}"
                      : "₦0.00",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ],
            ))
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

  void showEnergyWalletBottomDialog() {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        margin: const EdgeInsets.all(12),
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
                        child:   FocusScope(
                        child: Focus(
                      onFocusChange: (focus) => {
                        setState(() {
                          if (focus == true) {
                            walletAmountFocusMargin = 300;
                          } else {
                            walletAmountFocusMargin = 10;
                          }
                        })
                      },
                      child: TextFormField(
                        cursorColor: primaryColor,
                        controller: walletAmountTC,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: "Amount (Ex: ₦2,000)",
                            labelText: "Enter amount here",
                            labelStyle: TextStyle(color: primaryColor),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor))),
                      ),
                    ))),
                    Constants.topMargin(kIsWeb ? 0 : 10),
                    Visibility(
                        visible: kIsWeb ? false : true,
                        child:   Container(
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
                                walletAmount: int.parse(walletAmountTC.text),
                                screenType: "Desktop",
                              );
                            } else {
                              String? email =
                                  await MySharedPreferences.getString(
                                      key: "email");

                              Constants.goToNewPage(
                                  ChargeCardScreen(walletAmountTC.text, email!),
                                  context);
                            }
                            walletAmountTC.clear();
                          }
                        },
                        child: const Text("Fund Wallet"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor)),
                      ),
                    )),
                    Constants.topMargin(walletAmountFocusMargin)
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
}
