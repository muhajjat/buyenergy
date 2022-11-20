import 'package:buy_energy/Authentication/MainAuthentication/signupScreen.dart';
import 'package:buy_energy/MyDatabase/Authentication.dart';
import 'package:buy_energy/Widgets/myDialogs.dart';
import 'package:buy_energy/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreenDesktop extends StatefulWidget {
  const LoginScreenDesktop({Key? key}) : super(key: key);

  @override
  State<LoginScreenDesktop> createState() => LoginScreenDesktopState();
}

class LoginScreenDesktopState extends State<LoginScreenDesktop> {
  TextEditingController emailTC = TextEditingController(),
      passwordTC = TextEditingController();

  bool loginBtn = true, loader = false;

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
                    width: 500,
                    height: 460,
                    margin:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: ListView(
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.asset(
                          "images/logo.png",
                          width: 180,
                        )),
                        const Text(
                          "User Login",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                        ),
                        const Text(
                          "Welcome back to Buy Energy",
                          style: TextStyle(fontSize: 14),
                        ),
                        topMargin(),
                        TextFormField(
                          controller: emailTC,
                          cursorColor: primaryColor,
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
                        TextFormField(
                          controller: passwordTC,
                          cursorColor: primaryColor,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password (Ex: ******)",
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
                        Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () {
                                  MyDialogs.showForgotPasswordDialog(context);
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style:
                                      TextStyle(color: Colors.deepPurpleAccent),
                                ))),
                        topMargin(),
                        Visibility(
                            visible: loader,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                ),
                                const Text(
                                    "Fetching your details from the server. Please wait...")
                              ],
                            )),
                        Visibility(
                            visible: loginBtn,
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (emailTC.text.isEmpty ||
                                        passwordTC.text.isEmpty) {
                                      showErrorToast(
                                          "One or more fields is empty");
                                    } else if (passwordTC.text.length < 6) {
                                      showErrorToast(
                                          "Password cannot be less than 6 characters");
                                    } else {
                                      Authentication.loginUser(
                                          context: context,
                                          email: emailTC.text,
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
                                    "Login",
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
                                                  const SignupScreen()));
                                    },
                                    child: const Text(
                                      "New user? Signup here",
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
                  style: TextStyle(color: primaryColor, fontSize: 13),
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
