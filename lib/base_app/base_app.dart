import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/services/auth_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/screens/login_screen/login_screen.dart';
import 'package:janajal/ui/screens/upgrade_screen/upgrade_screen.dart';
import 'package:janajal/utils/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  PackageInfo? packageInfo;
  bool load = true;
  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }

  getAppInfo() async {
    packageInfo = await PackageInfo.fromPlatform();

    print(packageInfo!.version);
  }

  getUser() async {
    getAppInfo();
    CustomDialogs.showLoading();
    print("object");
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
    return Scaffold(
        body: !load
            ? UpgradeAlert(
                upgrader: Upgrader(
                    canDismissDialog: false,
                    durationUntilAlertAgain: Duration(seconds: 1),
                    onUpdate: () {
                      return false;
                    },
                    countryCode: 'IN',
                    debugLogging: false,
                    showReleaseNotes: false,
                    dialogStyle: UpgradeDialogStyle.material,
                    showIgnore: false,
                    showLater: false,
                    willDisplayUpgrade: (
                        {String? appStoreVersion,
                        required bool display,
                        String? installedVersion,
                        String? minAppVersion}) async {
                      if (display) {
                        await Future.delayed(Duration(milliseconds: 50));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => UpgradeScreen()),
                            (route) => false);
                      }
                    }),
                child: LoginScreen(),
              )
            : Container());
  }
}
