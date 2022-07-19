import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/controller/ui.controller.dart';
import 'package:janajal/models/user_model.dart';
import 'package:janajal/services/api_calls.dart';
import 'package:janajal/services/wallet_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/helping_widget/custom_snackbar.dart';
import 'package:janajal/ui/screens/login_screen/widget.dart';
import 'package:janajal/ui/screens/main_widget.dart';
import 'package:janajal/utils/api_body.dart';
import 'package:janajal/utils/apis.dart';
import 'package:janajal/utils/shared_pref.dart';
import 'package:provider/provider.dart';

class AuthServices {
  static authenticateUser(
      BuildContext context, String username, String password) async {
    Map<String, dynamic> data = await ApiCalls.postCall(
        methodName: Apis.authenticateUser,
        body: ApiBody.getAuthenticationBody('118@$username', password),
        context: context);
    if (data.isNotEmpty) {
      if (int.tryParse(data['S:Envelope']['S:Body']
                          ['ns2:authenticateUserResponse']['return']
                      .toString())
                  .runtimeType ==
              int
          ? true
          : false) {
        EasyLoading.showSuccess('Login Successful');
        await getUserDetails(context, username, password);
      } else if (data['S:Envelope']['S:Body']['ns2:authenticateUserResponse']
              ['return'] ==
          'Invalid Credentials') {
        await GoogleSignIn().signOut();
        CustomDialogs.dismissLoading();
        CustomDialogs.showToast('Invalid Credentials');
      }
    } else {
      CustomDialogs.showToast('Oops!\nSomething Went Wrong:::');
    }
  }

  static userSignup(
      BuildContext context,
      String username,
      String password,
      String firstName,
      String lastName,
      String gender,
      String signIn,
      String email,
      String mobile,
      String pincode,
      String country,
      String address) async {
    try {
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.customerSignUp,
          body: ApiBody.getSignupBody(
            firstName,
            '',
            email,
            username,
            password,
            '1234',
            signIn,
            "N/A",
            address,
            gender,
            pincode,
            country,
            lastName,
          ),
          context: context);
      print(data);
      if (int.tryParse(data['S:Envelope']['S:Body']
                          ['ns2:customerSignupResponse']['return']
                      .toString())
                  .runtimeType ==
              int
          ? true
          : false) {
        await authenticateUser(context, username, password);
      }
    } catch (e) {
      EasyLoading.showToast('Something went wrong $e');
    }
  }

  static getUserDetails(BuildContext context, String username, String password,
      {bool navigat = true}) async {
    Map<String, dynamic> data = await ApiCalls.postCall(
        methodName: Apis.authenticateUser,
        body: ApiBody.getUserDetails('118@$username', password),
        context: context);
    if (data.isNotEmpty) {
      String dataString =
          data['S:Envelope']['S:Body']['ns2:getUserDetailsResponse']['return'];

      UserModel userModel = UserModel.fromJson(jsonDecode(dataString));

      Provider.of<AuthController>(context, listen: false)
          .changeUserModel(userModel);
      Provider.of<AuthController>(context, listen: false)
          .changeUserNamePass(username, password);

      Provider.of<UiController>(context, listen: false).changeNavbarIndex(0);
      SharedPref.updateUserInSharedPrefs(userModel, username, password);
      await WalletServices.getWalletDetails(context);

      if (navigat) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
          return MainWidget();
        }), (route) => false);
      }
    } else {
      CustomDialogs.showToast('Oops!\nSomething Went Wrong');
    }
  }

  static Future<bool> checkEmailExist(
      String email, BuildContext context) async {
    Map<String, dynamic> data = await ApiCalls.postCall(
        methodName: Apis.authenticateUser,
        body: ApiBody.getCheckEmailBody(email),
        context: context);

    if (data['S:Envelope']['S:Body']['ns2:checkEmailResponse']['return'] ==
        '1') {
      CustomDialogs.showToast('Email already Exist');
      return true;
    } else {
      return false;
    }
  }

  static checkMobileExist(String mobile, BuildContext context) async {
    Map<String, dynamic> data = await ApiCalls.postCall(
        methodName: Apis.authenticateUser,
        body: ApiBody.getCheckMobileBody(mobile),
        context: context);
    if (data['S:Envelope']['S:Body']['ns2:checkMobileResponse']['return'] ==
        '1') {
      CustomDialogs.showToast('Mobile already Exist');
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getPassword(String email, BuildContext context) async {
    Map<String, dynamic> data = await ApiCalls.postCall(
        methodName: Apis.authenticateUser,
        body: ApiBody.getPasswordBody(email),
        context: context);

    if (data['S:Envelope']['S:Body']['ns2:getPasswordResponse']['return'] ==
        0) {
      CustomDialogs.showToast('Something went wrong');
      return '';
    } else {
      return data['S:Envelope']['S:Body']['ns2:getPasswordResponse']['return'];
    }
  }

  static Future<Map<String, dynamic>?> loginViaOtp(
      BuildContext context, String username) async {
    try {
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.authenticateUser,
          body: ApiBody.loginViaOTPBody('118@$username'),
          context: context);

      if (data['S:Envelope']['S:Body']['ns2:loginViaOTPResponse'] == null) {
        CustomDialogs.showToast('No user found with this email/phone');
        return null;
      } else {
        return jsonDecode(
            data['S:Envelope']['S:Body']['ns2:loginViaOTPResponse']['return']);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static isMobileVerified(BuildContext context, String otp) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.authenticateUser,
          body: ApiBody.verifyOTPBody('118@$username', password!, otp),
          context: context);
      print(data['S:Envelope']['S:Body']['ns2:mobileVerifiedResponse']['return']
          .runtimeType);
      if (data['S:Envelope']['S:Body']['ns2:mobileVerifiedResponse']['return']
              .toString() ==
          '1') {
        // CustomDialogs.showToast('No user found with this email/phone');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static sendOtp(BuildContext context, String mobile) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, dynamic> data = await ApiCalls.postCall(
        methodName: Apis.authenticateUser,
        body: ApiBody.getOtp('118@$username', password!, mobile),
        context: context,
      );
      Map<String, dynamic> json =
          data['S:Envelope']['S:Body']['ns2:customerUpdateOTPResponse'];
      if (json['return'] != null) {
        showOtpBottomSheet(
          context,
          username!,
          password,
          int.parse(json['return']),
          mobile: mobile,
          isLogin: false,
        );
      } else {
        CustomDialogs.showToast("Otp not sent");
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static verifyMobileOtp(
      BuildContext context, String mobile, String otp) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      String? custId = Provider.of<AuthController>(context, listen: false)
          .getUserModel!
          .custId!;
      Map<String, dynamic> data = await ApiCalls.postCall(
        methodName: Apis.authenticateUser,
        body: ApiBody.updateMobileVerification(
            '118@$username', password!, mobile, custId, otp),
        context: context,
      );
      Map<String, dynamic> json =
          data['S:Envelope']['S:Body']['ns2:updateMobileVerificationResponse'];

      if (json['return'] != null) {
        if (json['return'] == "1") {
          await AuthServices.getUserDetails(
            context,
            username!,
            password,
          );
        }
      } else {
        CustomDialogs.showToast("Otp not sent");
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
