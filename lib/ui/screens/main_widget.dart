import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:janajal/controller/ui.controller.dart';
import 'package:janajal/services/wallet_service.dart';
import 'package:janajal/services/watm_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/helping_widget/custom_navbar.dart';
import 'package:janajal/ui/screens/qr_screen/qr_screen.dart';
import 'package:janajal/ui/screens/upgrade_screen/upgrade_screen.dart';
import 'package:janajal/utils/validator.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

class MainWidget extends StatefulWidget {
  final bool showToast;
  final String toastString;
  const MainWidget({Key? key, this.showToast = false, this.toastString = ''})
      : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  String deviceId = '';

  @override
  void initState() {
    callApi();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // do something
      print("Build Completed");
    });
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    widget.showToast ? CustomDialogs.showToast(widget.toastString) : null;
    await Future.delayed(Duration(milliseconds: 1600));
    WalletServices.getOfferList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiController>(builder: (context, notifier, _) {
      return UpgradeAlert(
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
                    MaterialPageRoute(builder: (context) => UpgradeScreen()),
                    (route) => false);
              }
            }),
        child: Scaffold(
            extendBody: false,
            resizeToAvoidBottomInset: true,
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/backgroundOne.png',
                      ),
                      fit: BoxFit.fill)),
              child: notifier.mainWidget,
            ),
            bottomNavigationBar: const CustomNavbar()),
      );
    });
  }
}
