import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:janajal/utils/shared_pref.dart';

class Janajal {
  // colors
  static final Color primaryColor = Colors.blue.shade900;
  static final Color secondaryColor = Colors.lightBlue;

  // SharedPref constants
  static const String email = "email";
  static const String password = "Password";
  static const String mobile = "mobile";
  static const String name = "name";
  static const String custId = "customerId";
  static const String username = "username";
  static const String userModel = "userModel";
  static const Map<String, int> deliveryWindow = {
    '09:00 AM - 11:00 AM': 1,
    '11:00 AM - 01:00 PM': 2,
    '01:00 PM - 03:00 PM': 3,
    '03:00 PM - 05:00 PM': 4,
    '05:00 PM - 07:00 PM': 5,
  };
  static const double pricePerLitre = 1.0;

  static const String helperNumber = '0120-4605400';
  static const String helperEmail = 'crm@janajal.com';

  static const String aboutDesc =
      'JanaJal,  a unique social enterprise is the flagship initiative of the Supremus Group of Companies based in New Delhi. '
      'The company is working to make safe drinking water available and accessible to '
      'communities in an affordable manner through installation, operation and management of water '
      'ATM across railway stations, bus stands, municipal corporations and all urban, semi-urban and rural '
      'areas. JanaJal has been deeply aligned with the Swachh Bharat mission and aims to deliver One '
      'billion litres of safe drinking water to people by 2020. The company has received several awards and '
      'recognitions globally including the Flourish Prize for its contribution to SDG6 of the UN.\nFor further details visit:- ';

  static const String aboutDesc1 =
      'for its contribution to SDG6 of the UN.\nFor further details visit ';

  static const String certifications = 'Certifications';

  static const String tncDesc =
      '- JanaJal app owner can maintain ownership of all aspects of the app.'
      '\n - JanaJal  app owner can restrict certain abusive behaviors by those accessing the software'
      '\n - JanaJal  app owner can limit his liability to the user'
      '\n - JanaJal  app owner and retain the right to terminate a user’s account if need be JanaJal app can access your current location.'
      '\n - You should make sure you keep your mobile telephone or tablet and the security details you use to log onto the Mobile App safe and secure.'
      '\n - You must let us know as soon as possible if these are lost or stolen or misappropriated or used the card in an unauthorized and unusual manner.'
      '\n - You may be responsible for unauthorized payments made from your accounts if you have not kept your mobile telephone or tablet and your security details safe.';

  static const String privacyPolicyDesc =
      'By completing  this survey you agree to our privacy policy.';
}

class RazorPayKey {
  static const String TEST_Key = 'rzp_test_w8pVv1B5DWhWcW';
  static const String LIVE_KEY = 'rzp_live_wrrcjwswwZwgYV';
  static const String LIVE_SECERET_KEY = 'C7rCXaAHJAmGLcRhG91jE2WB';
  static const String TEST_SECERET_KEY = 'nXvuSw81o65fjEsrojskyAap';
}

class AtomCred {
  static String merchantId = '50613';
  static String txnscamt = '0';
  static String loginid = '50613';
  static String pass = 'SUPREMUS@123';
  static String prodid = 'SUPREMUS';
  static String txncurr = 'INR';
  static String clientCode = base64Encode(latin1.encode("007"));
  static String custacc = "100000036600";
  static String discriminator = "All";
  static String signatureRequest = 'c2ebc7b497de380002';
  static String signatureResponse = 'b08c2858fc6c95ce52';
}
