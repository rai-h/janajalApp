import 'package:flutter/material.dart';
import 'package:janajal/utils/janajal.dart';

class TermsConditionsScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios_new_sharp)),
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: const Text(
            'Terms and Conditions',
            style: TextStyle(
                fontSize: 24,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: new TextSpan(
                            children: [
                              new TextSpan(
                                text: Janajal.tncDesc,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400),
                              ),
                              TextSpan(
                                text: '\n\n\n',
                              ),
                              TextSpan(
                                text: 'Privacey Policy',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400),
                              ),
                              TextSpan(
                                text: '\n',
                              ),
                              TextSpan(
                                text: Janajal.privacyPolicyDesc,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400),
                              ),
                              TextSpan(
                                text: '\n\n',
                              ),
                              TextSpan(
                                text: 'What we collect',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400),
                              ),
                              TextSpan(
                                text: '\n',
                              ),
                              TextSpan(
                                text:
                                    'We may collect the following information.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400),
                              ),
                              TextSpan(
                                text:
                                    '\n - Name,contact info, including email add postcode.'
                                    '\n - Other information relevant to customer surveys and offers.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400),
                              ),
                              TextSpan(
                                text: '\n\n',
                              ),
                              TextSpan(
                                text:
                                    'What we do with the information we gather:',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400),
                              ),
                              TextSpan(
                                text:
                                    '\n - We require this information to understand your needs & provide you with a better service & in particular for the following reasons.'
                                    '\n - Internal record keeping.'
                                    '\n - We may use the information to improve our product & services.'
                                    '\n - We may periodically send promotional message about special offers.'
                                    '\n - We may use the information to customize the website according to your interest.'
                                    '\n - We will never sell your information.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400),
                              ),
                              TextSpan(
                                text: '\n\n',
                              ),
                              TextSpan(
                                text: 'Security',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400),
                              ),
                              TextSpan(
                                text:
                                    '\n We are committed to ensuring that your information is secure.In order to prevent unauthorized access or disclosure we have put in place suitable physical ,electronic and managerial procedure to safeguard  and secure the information we collect online.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: screenSize.width,
                        height: 1.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
