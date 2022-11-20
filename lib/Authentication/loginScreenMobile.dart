// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables

import 'package:buy_energy/Authentication/MainAuthentication/signupScreen.dart';
import 'package:buy_energy/MyDatabase/Authentication.dart';
import 'package:buy_energy/Widgets/myDialogs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Animations/fade_animation.dart';
import '../constants.dart';

class LoginScreenMobile extends StatefulWidget {
  const LoginScreenMobile({Key? key}) : super(key: key);

  @override
  State<LoginScreenMobile> createState() => LoginScreenMobileState();
}

class LoginScreenMobileState extends State<LoginScreenMobile> {
  bool _isVisible = false;

  late String? emailAddress = "", password = "";

  _togglePasswordVisibilty() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TextEditingController staffIdTC =TextEditingController(text: "KB-");

    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
          //   ConnectivityWidget(
          // builder: (context, isOnline) =>

          Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          primaryColor,
          Color.fromARGB(255, 120, 51, 253),
          Color.fromARGB(255, 97, 25, 212)
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "User Login",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Log into your existing account",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "images/logo.png",
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 226, 224, 224)))),
                                    child: TextFormField(
                                      cursorColor: primaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          emailAddress = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText:
                                              "example@buyenergyunits.com",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          labelText: "Email ID",
                                          labelStyle:
                                              TextStyle(color: primaryColor),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 210, 208, 208)))),
                                    child: TextFormField(
                                      cursorColor: primaryColor,
                                      onChanged: ((value) {
                                        setState(() {
                                          password = value;
                                        });
                                      }),
                                      obscureText: !_isVisible,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Password",
                                        labelStyle:
                                            TextStyle(color: primaryColor),
                                        border: InputBorder.none,
                                        suffixIcon: InkWell(
                                          child: _isVisible
                                              ? Icon(
                                                  Icons.visibility_off,
                                                  color: primaryColor,
                                                )
                                              : Icon(
                                                  Icons.visibility,
                                                  color: Colors.grey,
                                                ),
                                          onTap: () {
                                            _togglePasswordVisibilty();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                          onPressed: () {
                                            MyDialogs.showForgotPasswordDialog(
                                                context);
                                          },
                                          child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                                color: Colors.deepPurpleAccent),
                                          )))
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        // FadeAnimation(
                        //     1.5,
                        //     TextButton(
                        //       onPressed: () {},
                        //       child: Text(
                        //         "Forgot Password?",
                        //         style: TextStyle(color: Colors.grey),
                        //       ),
                        //     )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.6,
                            GestureDetector(
                                onTap: () async {
                                  /// Temporary
                                  // Constants.goToNewPagePushReplacement(
                                  //     HomeScreen(), context);

                                  // if (isOnline) {
                                  if (emailAddress == "" || password == "") {
                                    Fluttertoast.showToast(
                                        msg: "One or more fields are empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 3);
                                  } else {
                                    Authentication.loginUser(
                                        context: context,
                                        email: emailAddress!,
                                        password: password!);
                                  }
                                  // } else {
                                  //    Constants.showToast(
                                  //        msg:
                                  //            "Please connect your device to an active internet to proceed.",
                                  //        timeInSecForIosWeb: 3);
                                  // }
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: primaryColor),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ))),

                        TextButton(
                            onPressed: () {
                              Constants.goToNewPage(SignupScreen(), context);
                            },
                            child: Text(
                              "New user? Signup here",
                              style: TextStyle(color: Colors.deepPurpleAccent),
                            )),
                        SizedBox(
                          height: 50,
                        ),
                        // FadeAnimation(1.7, Text("Continue with social media", style: TextStyle(color: Colors.grey),)),
                        SizedBox(
                          height: 30,
                        ),
                        // Row(
                        //   children: <Widget>[
                        //     Expanded(
                        //       child: FadeAnimation(1.8, Container(
                        //         height: 50,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(50),
                        //           color: Colors.blue
                        //         ),
                        //         child: Center(
                        //           child: Text("Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        //         ),
                        //       )),
                        //     ),
                        //     SizedBox(width: 30,),
                        //     Expanded(
                        //       child: FadeAnimation(1.9, Container(
                        //         height: 50,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(50),
                        //           color: Colors.black
                        //         ),
                        //         child: Center(
                        //           child: Text("Github", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        //         ),
                        //       )),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // )
    );
  }

  Widget topMargin(double margin) {
    return Container(
      margin: EdgeInsets.only(top: margin),
    );
  }
}
