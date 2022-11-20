// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables

import 'package:buy_energy/Authentication/MainAuthentication/loginScreen.dart';
import 'package:buy_energy/MyDatabase/Authentication.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Animations/fade_animation.dart';
import '../Data/companyDetails.dart';
import '../constants.dart';

class SignupScreenMobile extends StatefulWidget {
  const SignupScreenMobile({Key? key}) : super(key: key);

  @override
  State<SignupScreenMobile> createState() => SignupScreenMobileState();
}

class SignupScreenMobileState extends State<SignupScreenMobile> {
  bool _isVisible = false, termsAndConditionsValue = false;

  late String? firstNameValue = "",
      lastNameValue = "",
      emailAddressValue = "",
      mobileNumberValue = "",
      refEmailValue = "",
      selectedCountryValue = "Select Country",
      passwordValue = "";

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
                        "Signup",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "New user registration",
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
                                          firstNameValue = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: "E.g John",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          labelText: "First Name",
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
                                                    255, 226, 224, 224)))),
                                    child: TextFormField(
                                      cursorColor: primaryColor,
                                      //controller: staffIdTC,
                                      onChanged: (value) {
                                        setState(() {
                                          lastNameValue = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: "E.g Thomos",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          labelText: "Last Name",
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
                                                    255, 226, 224, 224)))),
                                    child: TextFormField(
                                      cursorColor: primaryColor,
                                      //controller: staffIdTC,
                                      onChanged: (value) {
                                        setState(() {
                                          emailAddressValue = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: "example@buyenergy.com",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          labelText: "Email ID",
                                          labelStyle:
                                              TextStyle(color: primaryColor),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showCountryPicker(
                                          context: context,
                                          showPhoneCode: true,
                                          // optional. Shows phone code before the country name.
                                          onSelect: (Country country) {
                                            setState(() {
                                              selectedCountryValue =
                                                  country.displayName;
                                            });
                                          },
                                        );
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 17,
                                              top: 17),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Color.fromARGB(255,
                                                          226, 224, 224)))),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              selectedCountryValue!,
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 16),
                                            ),
                                          ))),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 226, 224, 224)))),
                                    child: TextFormField(
                                      cursorColor: primaryColor,
                                      //controller: staffIdTC,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          mobileNumberValue = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter Mobile Number",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          labelText: "Mobile Number",
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
                                                    255, 226, 224, 224)))),
                                    child: TextFormField(
                                      cursorColor: primaryColor,
                                      //controller: staffIdTC,
                                      // keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          refEmailValue = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText:
                                              "Enter Referral Email Here (Optional)",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          labelText: "Who referred you?",
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
                                      //controller: PasswordTC,
                                      onChanged: ((value) {
                                        setState(() {
                                          passwordValue = value;
                                        });
                                      }),
                                      obscureText: !_isVisible,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Create Password",
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: termsAndConditionsValue,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    termsAndConditionsValue = value!;
                                  });
                                }),


                          InkWell(
                              onTap: () => launchUrl(Uri.parse(termsAndConditionsUrl)),
                              child: Text("I agree to the Terms & Conditions"))
                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        FadeAnimation(
                            1.6,
                            GestureDetector(
                                onTap: () async {
                                  var emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                  // if (isOnline) {
                                  if (emailAddressValue == "" ||
                                      firstNameValue == "" ||
                                      lastNameValue == "" ||
                                      mobileNumberValue == "" ||
                                      selectedCountryValue ==
                                          "Select Country" ||
                                      passwordValue == "") {
                                    Constants.showToast(
                                        msg: "One or more fields are empty",
                                        timeInSecForIosWeb: 3);

                                    //  Fluttertoast.showToast(
                                    //      msg: deviceId!.toString(),
                                    //      toastLength: Toast.LENGTH_SHORT,
                                    //      timeInSecForIosWeb: 3);
                                  } else if (!emailValid
                                      .hasMatch(emailAddressValue!)) {
                                    Constants.showToast(
                                        msg:
                                            "Please enter a valid email address",
                                        timeInSecForIosWeb: 3);
                                  } else if (termsAndConditionsValue == false) {
                                    Constants.showToast(
                                        msg:
                                            "Please accept the terms and conditions to proceed",
                                        timeInSecForIosWeb: 3);
                                  } else {
                                    Authentication.signUp(
                                        context: context,
                                        firstName: firstNameValue!,
                                        lastName: lastNameValue!,
                                        email: emailAddressValue!,
                                        country: selectedCountryValue!,
                                        mobileNumber: mobileNumberValue!,
                                        refEmail: refEmailValue!,
                                        password: passwordValue!);
                                  }
                                  // } else {
                                  //   Constants.showToast(
                                  //       msg:
                                  //           "Please connect your device to an active internet to proceed.",
                                  //       timeInSecForIosWeb: 3);
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
                                      "Create Account",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ))),

                        TextButton(
                            onPressed: () {
                              Constants.goToNewPage(LoginScreen(), context);
                            },
                            child: Text(
                              "Login Existing account here",
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
      //  )
    );
  }

  Widget topMargin(double margin) {
    return Container(
      margin: EdgeInsets.only(top: margin),
    );
  }
}
