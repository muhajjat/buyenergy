import 'package:buy_energy/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../MyDatabase/MyDb.dart';

class ChargeCardScreenDesktop extends StatefulWidget {
  String walletAmount, email;

  ChargeCardScreenDesktop(this.walletAmount, this.email);

  @override
  State<StatefulWidget> createState() {
    return ChargeCardScreenDesktopState();
  }
}

class ChargeCardScreenDesktopState extends State<ChargeCardScreenDesktop> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: !useBackgroundImage
                ? const DecorationImage(
                    image: ExactAssetImage('images/bg1.jpg'),
                    fit: BoxFit.fill,
                  )
                : null,
            color: Colors.black,
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                CreditCardWidget(
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Buy Energy',
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: primaryColor,
                  backgroundImage:
                      useBackgroundImage ? 'assets/card_bg.png' : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        'assets/mastercard.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: Colors.black,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Card Holder (Optional)',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     const Text(
                        //       'Glassmorphism',
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 18,
                        //       ),
                        //     ),
                        //     Switch(
                        //       value: useGlassMorphism,
                        //       inactiveTrackColor: Colors.grey,
                        //       activeColor: Colors.black,
                        //       activeTrackColor: Colors.green,
                        //       onChanged: (bool value) => setState(() {
                        //         useGlassMorphism = value;
                        //       }),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     const Text(
                        //       'Card Image',
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 18,
                        //       ),
                        //     ),
                        //     Switch(
                        //       value: useBackgroundImage,
                        //       inactiveTrackColor: Colors.grey,
                        //       activeColor: Colors.black,
                        //       activeTrackColor: Colors.green,
                        //       onChanged: (bool value) => setState(() {
                        //         useBackgroundImage = value;
                        //       }),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                margin: EdgeInsets.all(12),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    backgroundColor: const Color(0xff1b447b),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(12),
                                    child: const Text(
                                      'Fund Wallet Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'halter',
                                        fontSize: 14,
                                        package: 'flutter_credit_card',
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    // if (formKey.currentState!.validate()) {
                                      MyDb.chargeCardDirectly(
                                          context: context,
                                          cardNumber: cardNumber,
                                          expiryDate: expiryDate,
                                          cvvCode: cvvCode,
                                          amount:
                                              int.parse(widget.walletAmount),
                                      email: widget.email,
                                      );

                                  },
                                ))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
