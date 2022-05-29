import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Future.delayed(Duration(milliseconds: 100), () {
                Navigator.of(context).pop();
              });
            },
            child: Icon(Icons.arrow_back_ios_new_sharp)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'FAQs',
          style: TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        height: size.height - 100,
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/backgroundOne.png',
                ),
                fit: BoxFit.fill)),
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                FAQTileWidget(
                  answer: ' Yes all data is encrypted for security purpose.',
                  question: ' Is the mobile App Secure?',
                ),
                FAQTileWidget(
                  answer:
                      ' Presently only Android version 5 .0 and above are supported. Watch out for further updates.',
                  question: ' What O/S are supported?',
                ),
                FAQTileWidget(
                  answer:
                      ' Yes, this to ensure that you receive all the benefits and offers as a member of the JanaJal family.',
                  question:
                      ' Is registering/validating mobile number mandatory?',
                ),
//
                FAQTileWidget(
                  answer: 'Minimum Order Volume is 20Ltr. Upto 500Ltr.',
                  question: 'What is the Minimum Volume (Ltr)  I can order?',
                ),
                FAQTileWidget(
                  answer:
                      ' You can place from anywhere in India using the App, for a JanaJal WOW serviceable Region.',
                  question: 'Can I Order Water from Any Location?',
                ),
                FAQTileWidget(
                  answer: ' Yes, you can have multiple delivery locations.',
                  question: 'Can I Add Multiple Addresses for Delivery?',
                ),
                FAQTileWidget(
                  answer:
                      '   Yes, once the trip starts you can track the WOW from My Orders by tapping on the Order.',
                  question: 'Can I Track the Delivery?',
                ),
                FAQTileWidget(
                  answer:
                      'You may go to Wallet section and select Recharge button, alternatively you may click on menu and select Recharge option.',
                  question: 'How can I recharge my wallet?',
                ),
                FAQTileWidget(
                  answer:
                      'All payments can be made through a secured payment gateway that accepts Credit Cards, Debit Cards, UPI, and Net-banking along with e-Wallets.',
                  question: 'What are the various payment methods available?',
                ),
                FAQTileWidget(
                  answer:
                      'We encourage you to hydrate regularly and stay healthy. The amount you pay does not have any validity for expiry. But the JJDOUBLE offer has a limited validity period that varies from offer to offer and is stated clearly for your understanding.',
                  question: 'Does the recharge come with a validity?',
                ),
                FAQTileWidget(
                  answer:
                      'Yes, you can check the recharge logs by going to wallet section and clicking on ‘Recharge Logs’',
                  question: 'Can I check my recharge logs?',
                ),
                FAQTileWidget(
                  answer:
                      'Yes, you can check recent transactions by going to wallet section and clicking on ‘Txn Logs’.',
                  question: 'Can I track my consumption?',
                ),
                FAQTileWidget(
                  answer:
                      'You may easily locate a JanaJal WATM from a network across country by going to WATM Locator'
                      'section. Select from the list of cities and locate the WATMs available near you. Very soon every JanaJal water ATM will inform you of its presence once you arrive within its vicinity.',
                  question: 'How do I locate my nearest JanaJal WATM?',
                ),
                FAQTileWidget(
                  answer:
                      'No, the e-Wallet balance can only be used for payment at JanaJal Water ATMs.',
                  question:
                      'Can I use the wallet balance for other transaction or merchants?',
                ),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 10,
                  color: Colors.white.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Q. ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'Do you still have queries?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MaterialButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.blue,
                                child: Text(
                                  'Call Us',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                onPressed: () async {
                                  if (!await launchUrl(Uri.parse(
                                      'tel://${Janajal.helperNumber}')))
                                    throw 'Could not launch';
                                },
                              ),
                              MaterialButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.deepPurple,
                                child: Text(
                                  'Email Us',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                onPressed: () async {
                                  if (!await launchUrl(Uri.parse(
                                      'mailto:${Janajal.helperEmail}')))
                                    throw 'Could not launch';
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FAQTileWidget extends StatelessWidget {
  final question;
  final answer;
  const FAQTileWidget({Key? key, required this.answer, this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.white.withOpacity(0.6),
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ListTile(
              dense: false,
              title: RichText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Q. ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: question,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      )
                    ],
                  )),
              subtitle: RichText(
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'A. ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: answer,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
    ;
  }
}
