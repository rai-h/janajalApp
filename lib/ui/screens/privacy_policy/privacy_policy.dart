import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
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
                            TextSpan(
                              text: 'Privacy Policy',
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
                                    'We respect your preferences concerning the treatment of information that we may collect. This privacy policy explains what kind of information we collect, use, share and the security of your information in relation to our mobile applications ("applications" or "apps") and mobile services ("services").please take a moment to familiarize yourself with our privacy practices.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400)),
                            TextSpan(
                                text:
                                    '\nBy installing the apps on your mobile device, entering into, connecting to, accessing and/or using the apps, you agree to the terms and conditions set forth in this privacy policy, including to the possible collection and processing of your information and you are consenting to the use of cookies and other tracking technologies on your device. Please note: if you or, as applicable, your legal guardian, disagree to any term provided herein, you may not install, access and/or use the apps and you are requested to promptly erase them, and any part thereof, from your mobile device. ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400)),
                            TextSpan(
                              text: '\n\n',
                            ),
                            TextSpan(
                              text: 'What information we collect',
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
                                    'Our primary purpose in collecting information is to provide you with a safe, efficient and customized experience and to provide you with services and features that better meet your needs or requests.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400)),
                            TextSpan(
                              text: '\n\b1. Personal information',
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
                                    '\b\bWe do not store any personal information about you. Your information are directly send to our own server and not used anywhere else. "personal information" means personally identifiable information, such as your name, email address, imei, contact entries, files, photos, etc.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400)),
                            TextSpan(
                              text: '\n\b2. Non-Personal information',
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
                                    '\b\bWe collect non-personal information about your use of our apps and aggregated information regarding the usages of the apps. "non-personal information" means information that is of an anonymous nature, such as the type of mobile device you use, your mobile devices unique device id, location services, gps settings, operating system of your mobile and information about the way you use the applications.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400)),
                            TextSpan(
                              text: '\n\n',
                            ),
                            TextSpan(
                              text: 'Changes to our privacy policy:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.grey.shade400),
                            ),
                            TextSpan(
                                text:
                                    '\nThis privacy policy may be updated from time to time for any reason. We will notify you of any changes to our privacy policy by posting the new privacy policy here',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400)),
                            TextSpan(
                              text: '\n\n',
                            ),
                            TextSpan(
                              text: 'Contact us:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.grey.shade400),
                            ),
                            TextSpan(
                                text:
                                    '\nIf you have any questions regarding privacy while using the apps, or have questions about our practices, please contact us via email at crm@janajal.com',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade400)),
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
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
