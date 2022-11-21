import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Data/companyDetails.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';
import '../constants.dart';

class ContactUsScreenMobile extends StatefulWidget {
  // final Map userDetails;
  //
  // const ProfileScreen({Key? key, required this.userDetails}) : super(key: key);
  @override
  ContactUsScreenMobileState createState() => ContactUsScreenMobileState();
}

class ContactUsScreenMobileState extends State<ContactUsScreenMobile> {
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
                      Text("Contact Center", style: MyTextStyles().title),
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
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
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
                              Icons.email_outlined,
                              color: primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Email",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "$companyEmail",
                                    //  widget.userDetails["username"],
                                    style: TextStyle(fontSize: 18),
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
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 0),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Phone",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    companyMobileNumber,
                                    // widget.userDetails["phone"],
                                    style: TextStyle(fontSize: 18),
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
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 0),
                              blurRadius: 50,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.whatsapp,
                              color: primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "WhatsApp",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    whatsAppNumber,
                                    // widget.userDetails["phone"],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                      InkWell(
                          onTap: () => launchUrl(Uri.parse(linkedInUrl)),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 50,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.contactless_outlined,
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
                                        "LinkedIn",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        child: const Text("Visit Page"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),

                      InkWell(
                          onTap: () => launchUrl(Uri.parse(instagramUrl)),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 50,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.video_library_outlined,
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
                                        "Instagram",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        child: const Text(
                                          "Visit Page",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),

                      InkWell(
                          onTap: () => launchUrl(Uri.parse(twitterUrl)),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 50,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.ondemand_video_sharp,
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
                                        "Twitter",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        child: const Text(
                                          "Visit Page",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),

                      InkWell(
                          onTap: () => launchUrl(Uri.parse(youtubeUrl)),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 50,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.ondemand_video_sharp,
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
                                        "Youtube",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        child: const Text(
                                          "Visit Page",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
