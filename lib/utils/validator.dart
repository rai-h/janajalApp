import 'package:flutter/cupertino.dart';
import 'package:janajal/services/address_service.dart';
import 'package:janajal/services/auth_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';

class Validator {
  static String validateEmail(String email) {
    if (email.isEmpty) {
      return 'Please provide and email';
    }
    if (!isEmail(email)) {
      return 'Invalid Email';
    }
    return '';
  }

  static String validateUsename(String value) {
    if (value.isEmpty) {
      return 'Please enter a email/mobile';
    }
    if (!(validateEmail(value).isEmpty || validateMobile(value).isEmpty)) {
      print('object');
      return 'Please enter a valid email/mobile';
    }

    return '';
  }

  static Future<String> checkEmailExist(
      String email, BuildContext context) async {
    if (await AuthServices.checkEmailExist(email, context)) {
      return 'Email alredy exist';
    }
    return '';
  }

  static Future<String> checkMobileExist(
      String mobile, BuildContext context) async {
    if (await AuthServices.checkMobileExist(mobile, context)) {
      return 'Mobile alredy exist';
    }
    return '';
  }

  static String validatePass(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 4) {
      return 'Password length cannot be less than 4';
    }

    return '';
  }

  static bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  static String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return '';
  }

  static String validateName(String value) {
    final RegExp nameRegExp = RegExp('[a-zA-Z]');
    if (value.length == 0) {
      return 'Please enter your name';
    } else if (!nameRegExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return '';
  }

  static String validatePincode(String value) {
    final RegExp pincodeRegExp = RegExp(r'(^[1-9][0-9]{5}$)');
    if (value.length == 0) {
      return 'Please enter Pincode';
    }
    if (!pincodeRegExp.hasMatch(value)) {
      return 'Please enter a valid Pincode';
    }
    return '';
  }

  static String validateQuantity(String value) {
    final RegExp pincodeRegExp = RegExp(r'(^[0-9]$|^[1-9][0-9]$|^(100)$)');
    if (value.length == 0) {
      return 'Please enter Amount';
    }
    if (int.parse(value) < 20) {
      return 'Please enter amount more than 20';
    }
    if (!pincodeRegExp.hasMatch(value)) {
      return 'Please enter a valid Amount';
    }
    return '';
  }

  static String validateQr(String qrData) {
    print(qrData);
    if (!qrData.contains('Janajal')) {
      return 'Invalid QR';
    }

    return '';
  }

  static Future<String> checkPincodeForDelivery(
      BuildContext context, String pincode) async {
    if (await AddressServices.checkPicodeForDelivery(context, pincode)) {
      return '';
    }
    CustomDialogs.showToast('Pincode is not available for delivery');
    return 'Pincode is not available for delivery';
  }

  static String validateOtp(BuildContext context, String otp) {
    final RegExp pincodeRegExp = RegExp(r'(^[0-9]{4}$)');
    if (otp.length < 4) {
      return 'Please enter a four digit OTP';
    }
    if (!pincodeRegExp.hasMatch(otp)) {
      return 'Please enter a valid OTP';
    }

    return '';
  }
}
