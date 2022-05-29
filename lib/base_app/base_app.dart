import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/services/auth_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/screens/login_screen/login_screen.dart';
import 'package:janajal/utils/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  bool load = true;
  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }

  getUser() async {
    CustomDialogs.showLoading();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAuth = prefs.getBool('isAuth') ?? false;

    if (isAuth) {
      AuthController controller =
          Provider.of<AuthController>(context, listen: false);
      await SharedPref.getUserInSharedPrefs(context);
      await AuthServices.authenticateUser(
          context, controller.getUserName!, controller.getPassword!);
    }
    setState(() {
      load = false;
    });
    CustomDialogs.dismissLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: !load ? LoginScreen() : Container());
  }
}
