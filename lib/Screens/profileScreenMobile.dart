import 'package:buy_energy/Models/user.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

import '../MyDatabase/MyDb.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';
import '../constants.dart';

class ProfileScreenMobile extends StatefulWidget {
  // final Map userDetails;
  //
  // const ProfileScreen({Key? key, required this.userDetails}) : super(key: key);
  @override
  ProfileScreenMobileState createState() => ProfileScreenMobileState();
}

class ProfileScreenMobileState extends State<ProfileScreenMobile> {
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
    var appbarheight = AppBar().preferredSize.height;
    var statusbarheight = MediaQuery.of(context).padding.top;
    var screenheight =
        MediaQuery.of(context).size.height - (statusbarheight + appbarheight);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
        actions: [
          Image.asset("images/logo.png", fit: BoxFit.contain),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("My Profile", style: MyTextStyles().title),
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
            FutureBuilder<User>(
                future: futureUser,
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 0),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Full Name",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapShot.data!.firstName + " " +
                                                snapShot.data!.lastName,
                                            //  widget.userDetails["username"],
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(bottom: 10),
                              //   width: double.infinity,
                              //   padding: EdgeInsets.all(20),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     color: Colors.white,
                              //     boxShadow: [
                              //       BoxShadow(
                              //         color: Colors.black12,
                              //         offset: Offset(0, 0),
                              //         blurRadius: 50,
                              //         spreadRadius: 8,
                              //       ),
                              //     ],
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       Icon(
                              //         Icons.tag,
                              //         color: Colors.red,
                              //       ),
                              //       SizedBox(
                              //         width: 10,
                              //       ),
                              //       Expanded(
                              //         child: Column(
                              //           mainAxisSize: MainAxisSize.min,
                              //           crossAxisAlignment: CrossAxisAlignment.start,
                              //           children: [
                              //             Text(
                              //               "FIRS TIN",
                              //               style:
                              //                   TextStyle(fontWeight: FontWeight.bold),
                              //             ),
                              //             Text(
                              //               "0123456-1234",
                              //               style: TextStyle(fontSize: 18),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black12,
                                      offset: const Offset(0, 0),
                                      blurRadius: 50,
                                      spreadRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.phone_android_outlined,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Phone",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapShot.data!.mobileNumber,
                                            // widget.userDetails["phone"],
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black12,
                                      offset: const Offset(0, 0),
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
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Email",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapShot.data!.email,
                                            //   widget.userDetails["email"],
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.black12,
                                      offset: const Offset(0, 0),
                                      blurRadius: 50,
                                      spreadRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.home_work_outlined,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Country",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapShot.data!.country,
                                            // replace name with address in updated endpoint
                                            // widget.userDetails["state"],
                                            style: const TextStyle(fontSize: 18),
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
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                      margin: const EdgeInsets.only(top: 20),
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
        ),
      ),
    );
  }
}
