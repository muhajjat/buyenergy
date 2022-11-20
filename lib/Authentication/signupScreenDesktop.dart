import 'package:buy_energy/Authentication/MainAuthentication/loginScreen.dart';
import 'package:buy_energy/MyDatabase/Authentication.dart';
import 'package:buy_energy/constants.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Data/companyDetails.dart';

class SignupScreenDesktop extends StatefulWidget {
  const SignupScreenDesktop({Key? key}) : super(key: key);

  @override
  State<SignupScreenDesktop> createState() => SignupScreenDesktopState();
}

class SignupScreenDesktopState extends State<SignupScreenDesktop> {
  String selectedCountryValue = "Select Country";

  TextEditingController firstNameTC = TextEditingController(),
      lastNameTC = TextEditingController(),
      emailTC = TextEditingController(),
      mobileNumberTC = TextEditingController(),
      refEmailTC = TextEditingController(),
      passwordTC = TextEditingController();

  bool createUserBtn = true, loader = false, termsAndConditionsValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/desktop_bg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //   Color(0xFF8837FD),
        //   Color(0xFF8A60C6),
        //   Color(0xFF5B3493),
        // ], begin: Alignment.topRight, end: Alignment.bottomRight)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Center(
                      child: Card(
                color: Colors.white,
                elevation: 9,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.transparent)),
                child: Container(
                    width: 550,
                    height: 760,
                    margin:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.asset(
                          "images/logo.png",
                          width: 180,
                        )),
                        const Text(
                          "Create your new account here",
                          style: const TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                        ),
                        const Text(
                          "Enter your correct details below and continue",
                          style: TextStyle(fontSize: 14),
                        ),
                        topMargin(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: TextFormField(
                              cursorColor: primaryColor,
                              controller: firstNameTC,
                              decoration: InputDecoration(
                                hintText: "First Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: primaryColor)),
                              ),
                            )),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                            ),
                            Expanded(
                                child: TextFormField(
                              cursorColor: primaryColor,
                              controller: lastNameTC,
                              decoration: InputDecoration(
                                hintText: "Last Names",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: primaryColor)),
                              ),
                            )),
                          ],
                        ),
                        topMargin(),
                        TextFormField(
                          cursorColor: primaryColor,
                          controller: emailTC,
                          decoration: InputDecoration(
                            hintText:
                                "Email Address (Ex: example@buyenergy.com)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: primaryColor)),
                          ),
                        ),
                        topMargin(),
                        InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                // optional. Shows phone code before the country name.
                                onSelect: (Country country) {
                                  setState(() {
                                    selectedCountryValue = country.displayName;
                                  });
                                },
                              );
                            },
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 17, top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey, // red as border color
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    selectedCountryValue,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ))),
                        topMargin(),
                        TextFormField(
                          cursorColor: primaryColor,
                          controller: mobileNumberTC,
                          decoration: InputDecoration(
                            hintText: "Mobile Number (08xxxxxxxxx)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: primaryColor)),
                          ),
                        ),
                        topMargin(),
                        TextFormField(
                          cursorColor: primaryColor,
                          controller: refEmailTC,
                          decoration: InputDecoration(
                            hintText: "Referral Email (Optional)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: primaryColor)),
                          ),
                        ),
                        topMargin(),
                        TextFormField(
                          cursorColor: primaryColor,
                          controller: passwordTC,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Choose Password (Ex: ******)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: primaryColor)),
                          ),
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
                                onTap: () =>
                                    launchUrl(Uri.parse(termsAndConditionsUrl)),
                                child: const Text(
                                    "I agree to the Terms & Conditions"))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                            visible: createUserBtn,
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              margin: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    var emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                                    if (firstNameTC.text.isEmpty ||
                                        lastNameTC.text.isEmpty ||
                                        emailTC.text.isEmpty ||
                                        selectedCountryValue ==
                                            "Select Country" ||
                                        mobileNumberTC.text.isEmpty ||
                                        passwordTC.text.isEmpty) {
                                      showErrorToast(
                                          "One or more fields is empty");
                                    } else if (passwordTC.text.length < 6) {
                                      showErrorToast(
                                          "Password cannot be less than 6 characters");
                                    } else if (!emailValid
                                        .hasMatch(emailTC.text)) {
                                      Constants.showToast(
                                          msg:
                                              "Please enter a valid email address",
                                          timeInSecForIosWeb: 3);
                                    } else if (termsAndConditionsValue ==
                                        false) {
                                      Constants.showToast(
                                          msg:
                                              "Please accept the terms and conditions to proceed",
                                          timeInSecForIosWeb: 3);
                                    } else {
                                      Authentication.signUp(
                                          context: context,
                                          firstName: firstNameTC.text,
                                          lastName: lastNameTC.text,
                                          email: emailTC.text,
                                          country: selectedCountryValue,
                                          mobileNumber: mobileNumberTC.text,
                                          refEmail: refEmailTC.text.isEmpty
                                              ? ""
                                              : refEmailTC.text,
                                          password: passwordTC.text);
                                    }
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              primaryColor),
                                      //  backgroundColor: kPrimaryColorRed,
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)))),
                                  child: const Text(
                                    "Create User",
                                    style: TextStyle(fontSize: 16),
                                  )),
                            )),
                        topMargin(),
                        Center(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                    },
                                    child: const Text(
                                      "Already have an existing account? Login here",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: primaryColor),
                                    )))
                      ],
                    )),
              ))),
              //  Spacer(),

              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "© 2022. Buy Energy Units",
                  style: TextStyle(color:  primaryColor, fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget topMargin() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
    );
  }

  showNormalToast(String text) {
    Fluttertoast.showToast(
        msg: text, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 3);
  }

  showErrorToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red);
  }
}
