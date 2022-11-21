import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../Models/user.dart';
import '../MyDatabase/MyDb.dart';
import '../Widgets/desktopDrawer.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';

class ProfileScreenDesktop extends StatefulWidget {
  @override
  ProfileScreenDesktopState createState() => ProfileScreenDesktopState();
}

class ProfileScreenDesktopState extends State<ProfileScreenDesktop> {
  static late Future<User>? futureUser;
  Dio dio = Dio();

  var userId = 3;

  static initializeFutureUsers() {
    futureUser = MyDb.fetchUserDetails();
  }

  @override
  void initState() {
    if (mounted) {
      setState(() {
        MyDb.syncBaseUrl();
        initializeFutureUsers();
      });
    }

    super.initState();
  }

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
                        child: DesktopDrawer.drawerDetails(context, "My Profile"),
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
                                    Text("My Profile",
                                        style: MyTextStyles().title),
                                    SizedBox(height: 10),
                                    MyDivider(),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              Constants.topMargin(12),
                              FutureBuilder<User>(
                                  future: futureUser,
                                  builder: (context, snapShot) {
                                    if (snapShot.hasData) {
                                      return Expanded(
                                        child:  Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 250, top: 0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      const BoxShadow(
                                                        color: Colors.black12,
                                                        offset: Offset(0, 30),
                                                        blurRadius: 50,
                                                        spreadRadius: 8,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.person_outline,
                                                        color: primaryColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Full Name",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              snapShot.data!
                                                                      .firstName +
                                                                  " " +
                                                                  snapShot.data!
                                                                      .lastName,
                                                              //  widget.userDetails["username"],
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      const BoxShadow(
                                                        color: Colors.black12,
                                                        offset:
                                                            const Offset(0, 0),
                                                        blurRadius: 50,
                                                        spreadRadius: 8,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .phone_android_outlined,
                                                        color: primaryColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Phone",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              snapShot.data!
                                                                  .mobileNumber,
                                                              // widget.userDetails["phone"],
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      const BoxShadow(
                                                        color: Colors.black12,
                                                        offset:
                                                            const Offset(0, 0),
                                                        blurRadius: 50,
                                                        spreadRadius: 8,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.email_outlined,
                                                        color: primaryColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Email",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              snapShot
                                                                  .data!.email,
                                                              //   widget.userDetails["email"],
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      const BoxShadow(
                                                        color: Colors.black12,
                                                        offset:
                                                            const Offset(0, 0),
                                                        blurRadius: 50,
                                                        spreadRadius: 8,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .home_work_outlined,
                                                        color: primaryColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Country",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              snapShot.data!
                                                                  .country,
                                                              // replace name with address in updated endpoint
                                                              // widget.userDetails["state"],
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                              ],
                                            ),
                                          ),

                                      );
                                    } else {
                                      return Center(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: const SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator(
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  })
                            ],
                          )))),

              ],
            )));
  }
}
