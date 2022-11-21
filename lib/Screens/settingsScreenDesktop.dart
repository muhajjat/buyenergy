import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';
import '../MyDatabase/MyDb.dart';
import '../Widgets/desktopDrawer.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';

class SettingsScreenDesktop extends StatefulWidget {
  @override
  SettingsScreenDesktopState createState() => SettingsScreenDesktopState();
}

class SettingsScreenDesktopState extends State<SettingsScreenDesktop> {
  TextEditingController oldPasswordTC = TextEditingController(),
      newPasswordTC = TextEditingController(),
      confirmNewPasswordTC = TextEditingController();

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
                        child: DesktopDrawer.drawerDetails(context, "Settings"),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text("Settings",
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: primaryColor)),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: primaryColor)),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: primaryColor)),
                                      ),
                                    ),
                                    Constants.topMargin(20),
                                    SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (oldPasswordTC.text.isEmpty ||
                                                newPasswordTC.text.isEmpty ||
                                                confirmNewPasswordTC
                                                    .text.isEmpty) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "One or more fields are empty",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  timeInSecForIosWeb: 3);
                                            } else if (confirmNewPasswordTC
                                                    .text !=
                                                newPasswordTC.text) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "New password and confirm password do not match",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  timeInSecForIosWeb: 3);
                                            } else {
                                              // Update Password

                                              MyDb.updatePassword(
                                                  context: context,
                                                  oldPassword:
                                                      oldPasswordTC.text,
                                                  newPassword:
                                                      newPasswordTC.text);
                                            }
                                          },
                                          child: Text("Update Now"),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      primaryColor),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .transparent)))),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ))),
                )
              ],
            )));
  }
}
