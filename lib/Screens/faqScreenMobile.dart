
import 'package:buy_energy/Data/companyDetails.dart';
import 'package:buy_energy/constants.dart';
import 'package:flutter/material.dart';

import '../Data/faqs.dart';
import '../Widgets/divider.dart';
import '../Widgets/textStyle.dart';

class FAQScreenMobile extends StatefulWidget {
  final Map faqDetail;

  const FAQScreenMobile({Key? key, required this.faqDetail}) : super(key: key);
  @override
  FAQScreenMobileState createState() => FAQScreenMobileState();
}

class FAQScreenMobileState extends State<FAQScreenMobile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Image.asset("images/logo.png", fit: BoxFit.contain),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text("FAQs", style: MyTextStyles().title),
                SizedBox(height: 5),
                MyDivider(),
                SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),


            child: Text(aboutCompany,

            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 17,

            ),),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: ExpansionPanelList(
                  dividerColor: Colors.white,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      widget.faqDetail["qna"][index].isExpanded = !isExpanded;
                    });
                  },
                  children: widget.faqDetail["qna"].map<ExpansionPanel>((Item item) {
                    return ExpansionPanel(
                      backgroundColor: primaryColor,
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
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
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Text(item.expandedValue)),
                      ),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
