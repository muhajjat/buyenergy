import 'package:buy_energy/Screens/MainScreen/accountStatementsScreen.dart';
import 'package:buy_energy/Screens/MainScreen/airtimePurchaseScreen.dart';
import 'package:buy_energy/Screens/MainScreen/buyWaterUnitScreen.dart';
import 'package:buy_energy/Screens/MainScreen/contactUsScreen.dart';
import 'package:buy_energy/Screens/MainScreen/digitalInvoiceScreen.dart';
import 'package:buy_energy/Screens/MainScreen/faqScreen.dart';
import 'package:buy_energy/Screens/MainScreen/orderHistoryScreen.dart';
import 'package:buy_energy/Screens/MainScreen/profileScreen.dart';
import 'package:buy_energy/Screens/MainScreen/settingsScreen.dart';
import 'package:buy_energy/Screens/homeScreenDesktop.dart';
import 'package:flutter/material.dart';

import '../Screens/MainScreen/buyEnergyUnitScreen.dart';
import '../Screens/MainScreen/buySolarUnitScreen.dart';
import '../Screens/MainScreen/dataPurchaseScreen.dart';
import '../Screens/MainScreen/homeScreen.dart';
import '../Screens/MainScreen/referralScreen.dart';
import '../Screens/cableTVScreenDesktop.dart';
import '../constants.dart';
import 'myDialogs.dart';

class DesktopDrawer {
  static Widget drawerDetails(BuildContext context, String label) {
    return ListView(
      children: [
        Constants.topMargin(12),
        Image.asset(
          "images/logo.png",
          width: 90,
          height: 90,
        ),
        Divider(
          color: Colors.grey,
        ),
        Constants.topMargin(12),
        ListTile(
          onTap: () {
            label == "Dashboard"
                ? null
                : Constants.goToNewPage(HomeScreen(), context);
          },
          leading: Image.asset(
            "images/dashboard.png",
            color: label == "Dashboard" ? Colors.orange : Colors.black,
            width: 23,
            height: 23,
          ),
          title: Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 18,
              color: label == "Dashboard" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            label == "Buy Energy Units"
                ? null
                : Constants.goToNewPage(BuyEnergyUnitScreen(), context);
          },
          leading: Image.asset(
            "images/electricity.png",
            width: 23,
            height: 23,
            color: label == "Buy Energy Units" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Buy Energy Units",
            style: TextStyle(
              fontSize: 18,
              color: label == "Buy Energy Units" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Constants.goToNewPage(BuyWaterUnitScreen(), context);
          },
          leading: Image.asset(
            "images/water.png",
            width: 23,
            height: 23,
            color: label == "Buy Water Units" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Buy Water Units",
            style: TextStyle(
              fontSize: 18,
              color: label == "Buy Water Units" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Constants.goToNewPage(BuySolarUnitScreen(), context);
          },
          leading: Image.asset(
            "images/solar.png",
            width: 23,
            height: 23,
            color: label == "Buy Solar Units" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Solar Recharge Units",
            style: TextStyle(
              fontSize: 18,
              color: label == "Buy Solar Units" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            MyDialogs.showInfoDialog(
                context, "My Home Automation".toUpperCase(), "Coming Soon!");
          },
          leading: Image.asset(
            "images/automation.png",
            width: 23,
            height: 23,
            color: label == "My Home Automation" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "My Home Automation",
            style: TextStyle(
              fontSize: 18,
              color:
                  label == "My Home Automation" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            MyDialogs.showInfoDialog(
                context, "EV Charging".toUpperCase(), "Coming Soon!");
          },
          leading: Image.asset(
            "images/charging.png",
            width: 23,
            height: 23,
            color: label == "EV Charging" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "EV Charging",
            style: TextStyle(
              fontSize: 18,
              color: label == "EV Charging" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            MyDialogs.showInfoDialog(
                context, "Buy Gas Unit".toUpperCase(), "Coming Soon!");
          },
          leading: Image.asset(
            "images/gas.png",
            width: 23,
            height: 23,
            color: label == "Buy Gas Unit" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Buy Gas Unit",
            style: TextStyle(
              fontSize: 18,
              color: label == "Buy Gas Unit" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Constants.goToNewPage(AirtimePurchaseScreen(), context);
          },
          leading: Image.asset(
            "images/airtime.png",
            width: 23,
            height: 23,
            color: label == "Airtime" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Top up",
            style: TextStyle(
              fontSize: 18,
              color: label == "Airtime" ? Colors.orange : Colors.black,
            ),
          ),
        ),

        ListTile(
          onTap: () {
            Constants.goToNewPage(DataPurchaseScreen(), context);
          },
          leading: Image.asset(
            "images/data.png",
            width: 23,
            height: 23,
            color: label == "Data Bundle" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Data Bundle",
            style: TextStyle(
              fontSize: 18,
              color: label == "Data Bundle" ? Colors.orange : Colors.black,
            ),
          ),
        ),

        ListTile(
          onTap: () {
            Constants.goToNewPage(CableTVScreenDesktop(), context);
          },
          leading: Image.asset(
            "images/cabletv.png",
            width: 23,
            height: 23,
            color: label == "Cable TV" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Cable TV",
            style: TextStyle(
              fontSize: 18,
              color: label == "Cable TV" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            MyDialogs.showInfoDialog(
                context, "Eco System".toUpperCase(), "Coming Soon!");
          },
          leading: Image.asset(
            "images/ecosystem.png",
            width: 23,
            height: 23,
            color: label == "Eco System" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Eco System",
            style: TextStyle(
              fontSize: 18,
              color: label == "Eco System" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            MyDialogs.showInfoDialog(
                context, "Inventory Management".toUpperCase(), "Coming Soon!");
          },
          leading: Image.asset(
            "images/inventory.png",
            width: 23,
            height: 23,
            color:
                label == "Inventory Management" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Inventory Management",
            style: TextStyle(
              fontSize: 18,
              color: label == "Inventory Management"
                  ? Colors.orange
                  : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Constants.goToNewPage(OrderHistoryScreen(), context);
          },
          leading: Image.asset(
            "images/history.png",
            width: 23,
            height: 23,
            color: label == "Order History" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Order History",
            style: TextStyle(
              fontSize: 18,
              color: label == "Order History" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            MyDialogs.showInfoDialog(context,
                "Units Consumption Breakdown".toUpperCase(), "Coming Soon!");
          },
          leading: Image.asset(
            "images/breakdown.png",
            width: 23,
            height: 23,
            color: label == "Units Consumption Breakdown"
                ? Colors.orange
                : Colors.black,
          ),
          title: Text(
            "Units Consumption Breakdown",
            style: TextStyle(
              fontSize: 18,
              color: label == "Units Consumption Breakdown"
                  ? Colors.orange
                  : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            HomeScreenDesktopState.showEnergyWalletBottomDialog(context);
          },
          leading: Image.asset(
            "images/wallet.png",
            width: 23,
            height: 23,
          ),
          title: const Text(
            "My Energy Wallet",
            style: TextStyle(fontSize: 18),
          ),
        ),
        ListTile(
          onTap: () {
            Constants.goToNewPage(AccountStatementsScreen(), context);
          },
          leading: Image.asset(
            "images/statement.png",
            width: 23,
            height: 23,
            color: label == "Account Statements" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Account Statements",
            style: TextStyle(
              fontSize: 18,
              color:
                  label == "Account Statements" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Constants.goToNewPage(DigitalInvoiceScreen(), context);
          },
          leading: Image.asset(
            "images/invoice.png",
            width: 23,
            height: 23,
            color: label == "Digital Invoice" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Digital Invoice",
            style: TextStyle(
                fontSize: 18,
                color:
                    label == "Digital Invoice" ? Colors.orange : Colors.black),
          ),
        ),
        ListTile(
          onTap: () {
            Constants.goToNewPage(ProfileScreen(), context);
          },
          leading: Image.asset(
            "images/profile.png",
            width: 23,
            height: 23,
            color: label == "My profile" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "My Profile",
            style: TextStyle(
              fontSize: 18,
              color: label == "My Profile" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Constants.goToNewPage(SettingsScreen(), context);
          },
          leading: Image.asset(
            "images/settings.png",
            width: 23,
            height: 23,
            color: label == "Settings" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Settings",
            style: TextStyle(
              fontSize: 18,
              color: label == "Settings" ? Colors.orange : Colors.black,
            ),
          ),
        ),

        ListTile(
          onTap: () {
            MyDialogs.showInfoDialog(
                context, "E-Biller".toUpperCase(), "Coming Soon!");
          },
          leading: Image.asset(
            "images/wallet.png",
            width: 23,
            height: 23,

          ),
          title: Text(
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
          leading: Image.asset(
            "images/ecosystem.png",
            width: 23,
            height: 23,

          ),
          title: Text(
            "My Energy Card",
            style: TextStyle(
              fontSize: 18,

            ),
          ),
        ),

        ListTile(
          onTap: () {
            Constants.goToNewPage(ReferralScreen(), context);
          },
          leading: Image.asset(
            "images/referral.png",
            width: 23,
            height: 23,
            color: label == "Referral & Reward" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Referral & Reward",
            style: TextStyle(
              fontSize: 18,
              color:
                  label == "Referral & Reward" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Constants.goToNewPage(FAQScreen(), context);
          },
          leading: Image.asset(
            "images/faq.png",
            width: 23,
            height: 23,
            color: label == "FAQs" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "FAQs",
            style: TextStyle(
              fontSize: 18,
              color: label == "FAQs" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Constants.goToNewPage(ContactUsScreen(), context);
          },
          leading: Image.asset(
            "images/contact.png",
            width: 23,
            height: 23,
            color: label == "Contact Center" ? Colors.orange : Colors.black,
          ),
          title: Text(
            "Contact Center",
            style: TextStyle(
              fontSize: 18,
              color: label == "Contact Center" ? Colors.orange : Colors.black,
            ),
          ),
        ),
        // ListTile(
        //   onTap: () {
        //     MyDialogs.showLogoutDialog(context);
        //   },
        //   leading: Image.asset(
        //     "images/logout.png",
        //     width: 23,
        //     height: 23,
        //   ),
        //   title: const Text(
        //     "Logout",
        //     style: TextStyle(fontSize: 18),
        //   ),
        // ),
      ],
    );
  }
}
