import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:janajal/services/auth_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SocialAuth {
  static getGoogleAuth(BuildContext context) async {
    String password = '';

    try {
      final GoogleSignInAccount? googleUser =
          await getGoogleUserDetails(context);
      if (googleUser != null) {
        if (!(await AuthServices.checkEmailExist(googleUser.email, context))) {
          CustomDialogs.showToast('No user found');
        } else {
          password = await AuthServices.getPassword(googleUser.email, context);
          await AuthServices.authenticateUser(
              context, googleUser.email, password);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<GoogleSignInAccount?> getGoogleUserDetails(
      BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      return googleUser;
    } catch (e) {
      return null;
    }
  }

  static Future<LoginResult?> getFacebookUserDetails(
      BuildContext context) async {
    try {
      final LoginResult facebookUser = await FacebookAuth.instance.login();
      if (facebookUser.status == LoginStatus.success) {
        final AccessToken accessToken = facebookUser.accessToken!;
        final credential = FacebookAuthProvider.credential(accessToken.token);

        // await _firebaseAuth.signInWithCredential(credential);
      }
      return facebookUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static getGoogleSigup(BuildContext context) async {
    String password = '';

    try {
      final GoogleSignInAccount? googleUser =
          await getGoogleUserDetails(context);
      if (googleUser != null) {
        if ((await AuthServices.checkEmailExist(googleUser.email, context))) {
          await GoogleSignIn().signOut();
          CustomDialogs.showToast('User already exist with this email.');
        } else {
          AuthServices.userSignup(
              context,
              googleUser.email,
              password.isEmpty ? "admin" : password,
              googleUser.displayName ?? "",
              "",
              "",
              "1",
              googleUser.email,
              "",
              "-",
              "India",
              "-");
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
