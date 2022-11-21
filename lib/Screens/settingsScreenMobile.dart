// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unrelated_type_equality_checks

import 'dart:convert';

import 'package:buy_energy/MyDatabase/MyDb.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import "package:http/http.dart" as http;

import '../Widgets/divider.dart';
import '../Widgets/loader.dart';
import '../Widgets/textStyle.dart';
import '../constants.dart';
import '../enpoints.dart';

class SettingsScreenMobile extends StatefulWidget {
  @override
  State<SettingsScreenMobile> createState() => SettingsScreenMobileState();
}

class SettingsScreenMobileState extends State<SettingsScreenMobile> {
  TextEditingController oldPasswordTC = TextEditingController(),
      newPasswordTC = TextEditingController(),
      confirmNewPasswordTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      ),
      Opacity(
        opacity: 0.7,
        child: Image.asset(
          "images/bg1.jpg",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: primaryColor),
            actions: [
              //  Expanded(
              //       child: Align(
              //           alignment: Alignment.centerLeft,
              //           child: Container(
              //             margin: EdgeInsets.only(left: 20),
              //             child: Text("Dashboard".toUpperCase(), style: TextStyle(color: primaryColor, fontSize: 17, fontWeight: FontWeight.bold),),
              //           ))),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.asset("images/logo.png",
                    width: 75, height: 75, fit: BoxFit.contain),
              ),
            ],
          ),
          body:
          // ConnectivityWidget(
          //     builder: (context, isOnline) =>

                  Container(
                    padding: EdgeInsets.all(12),
                    child: ListView(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Constants.topMargin(10),
                          Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Settings", style: MyTextStyles().title),
                                    // TextButton.icon(
                                    //   onPressed: () {},
                                    //   icon: Icon(Icons.edit),
                                    //   label: Text("Edit"),
                                    // )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                MyDivider(),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                          Constants.topMargin(10),
                          Text(
                            "Old Password",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Constants.topMargin(5),
                          TextFormField(
                            obscureText: true,
                            controller: oldPasswordTC,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.multiline,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: primaryColor)),
                            ),
                          ),
                          Constants.topMargin(10),
                          Text(
                            "New Password",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Constants.topMargin(5),
                          TextFormField(
                            obscureText: true,
                            controller: newPasswordTC,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.multiline,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: primaryColor)),
                            ),
                          ),
                          Constants.topMargin(10),
                          Text(
                            "Confirm Password",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Constants.topMargin(5),
                          TextFormField(
                            obscureText: true,
                            controller: confirmNewPasswordTC,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.multiline,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: primaryColor)),
                            ),
                          ),
                          Constants.topMargin(20),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () async {
                                // if (isOnline) {
                                  if (oldPasswordTC.text.isEmpty ||
                                      newPasswordTC.text.isEmpty ||
                                      confirmNewPasswordTC.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "One or more fields are empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 3);
                                  } else if (confirmNewPasswordTC.text !=
                                      newPasswordTC.text) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "New password and confirm password do not match",
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 3);
                                  } else {
                                    // Update Password

                                   MyDb.updatePassword(context: context, oldPassword: oldPasswordTC.text, newPassword: newPasswordTC.text);
                                  }
                                // } else {
                                //   Fluttertoast.showToast(
                                //       msg:
                                //           "Please connect your device to an active internet to proceed.",
                                //       toastLength: Toast.LENGTH_LONG,
                                //       timeInSecForIosWeb: 2);
                                // }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          side: BorderSide(
                                              color: Colors.transparent)))),
                              child: Text("Update Now"),
                            ),
                          )
                        ]),
                  ))
      
     // )
    ]);
  }


}
