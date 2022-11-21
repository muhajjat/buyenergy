import 'package:flutter/material.dart';

import '../../constants.dart';
import '../Data/companyDetails.dart';
import '../Data/faqs.dart';
import '../Widgets/desktopDrawer.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';

class FAQScreenDesktop extends StatefulWidget {
  final Map faqDetail;

  const FAQScreenDesktop({Key? key, required this.faqDetail}) : super(key: key);

  @override
  FAQScreenDesktopState createState() => FAQScreenDesktopState();
}

class FAQScreenDesktopState extends State<FAQScreenDesktop> {
  TextEditingController oldPasswordTC = TextEditingController(),
      newPasswordTC = TextEditingController(),
      confirmNewPasswordTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbarColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: primaryColor),
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
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      child: Container(
                        width: 300,
                        child: DesktopDrawer.drawerDetails(context, "FAQs"),
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
                      margin: const EdgeInsets.only(
                          top: 12, left: 12, bottom: 12, right: 200),
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text("FAQs", style: MyTextStyles().title),
                                const SizedBox(height: 10),
                                MyDivider(),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          Constants.topMargin(12),
                          Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Text(
                              aboutCompany,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Constants.topMargin(12),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: ExpansionPanelList(
                              dividerColor: Colors.white,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  widget.faqDetail["qna"][index].isExpanded =
                                      !isExpanded;
                                });
                              },
                              children: widget.faqDetail["qna"]
                                  .map<ExpansionPanel>((Item item) {
                                return ExpansionPanel(
                                  backgroundColor: primaryColor,
                                  canTapOnHeader: true,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: Text(
                                          item.headerValue,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                  body: ListTile(
                                    title: Container(
                                        padding: EdgeInsets.all(15),
                                        margin: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Text(item.expandedValue)),
                                  ),
                                  isExpanded: item.isExpanded,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ))),
                ))
              ],
            )));
  }
}
