import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/models/user_model.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static getPrefInstance() async {
    return await SharedPreferences.getInstance();
  }

  static Future<Null> updateUserInSharedPrefs(
      UserModel userModel, String username, String password) async {
    final SharedPreferences prefs = await getPrefInstance();
    prefs.setBool('isAuth', true);
    prefs.setString(Janajal.userModel, jsonEncode(userModel.toJson()));
    prefs.setString(Janajal.password, password);
    prefs.setString(Janajal.username, username);
  }

  static Future<String> getOfferShownTime() async {
    final SharedPreferences prefs = await getPrefInstance();
    return prefs.getString('offerShownTime') ?? '';
  }

  static Future<Null> saveOfferShownTime(String timestamp) async {
    final SharedPreferences prefs = await getPrefInstance();
    prefs.setString('offerShownTime', timestamp);
  }

  static Future<bool> getUserInSharedPrefs(BuildContext context) async {
    final SharedPreferences prefs = await getPrefInstance();

    String? prefUserModel = await prefs.getString(Janajal.userModel);
    String? prefPassword = await prefs.getString(Janajal.password);
    String? prefUsername = await prefs.getString(Janajal.username);
    if (prefUsername != null && prefPassword != null) {
      Provider.of<AuthController>(context, listen: false)
          .changeUserNamePass(prefUsername, prefPassword);

      return true;
    }
    return false;
  }

  static Future<Null> removeUserFromSharedPrefs() async {
    final SharedPreferences prefs = await getPrefInstance();
    prefs.remove('isAuth');
    prefs.remove(Janajal.userModel);
    prefs.remove(Janajal.password);
    prefs.remove(Janajal.username);
  }
}
