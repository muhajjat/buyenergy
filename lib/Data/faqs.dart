

List faqs = [
  {
    "name": "",
    "qna": [
      Item(
        headerValue: "How to purchase utility bill",
        expandedValue: "Answers here..."

           ),
      Item(
          headerValue: "How to purchase Water",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "How to setup my Home Automation",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "How to purchase Gas Unit",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "How to use our Solar Recharge Pay as you Go",
          expandedValue:  "Answers here..."
      ),




      Item(
          headerValue: "How to charge my vehicle using Ev Charger",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "What kind of packages are Available",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "How to Order our Products",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "How to use our Energy Wallet and Energy Card",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "How to Generate Account Statement",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "How to use our service",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "How to create new account",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "Can create more than one Account",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "How can I keep my Account safe",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "I forgot my password what should I do",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "Want to talk to us",
          expandedValue:  "Answers here..."
      ),
      Item(
          headerValue: "What is Buy energy Units All About",
          expandedValue:  "Answers here..."
      ),

    ]
  },

];

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
