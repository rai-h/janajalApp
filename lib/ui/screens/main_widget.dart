import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:janajal/controller/ui.controller.dart';
import 'package:janajal/services/wallet_service.dart';
import 'package:janajal/services/watm_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/helping_widget/custom_navbar.dart';
import 'package:janajal/ui/screens/qr_screen/qr_screen.dart';
import 'package:janajal/utils/validator.dart';
import 'package:provider/provider.dart';

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
    widget.showToast ? CustomDialogs.showToast(widget.toastString) : null;
    widget.showToast
        ? Future.delayed(Duration(seconds: 2), (() {
            WalletServices.getWalletDetails(context);
          }))
        : WalletServices.getWalletDetails(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiController>(builder: (context, notifier, _) {
      return Scaffold(
          // floatingActionButton: notifier.navbarIndex == 0
          //     ? FloatingActionButton(
          //         child: const Icon(
          //           Icons.qr_code_scanner_rounded,
          //           size: 35,
          //           color: Colors.white,
          //         ),
          //         backgroundColor: Colors.blue.shade900,
          //         onPressed: () async {},
          //       )
          //     : null,
          extendBody: true,
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
          bottomNavigationBar: const CustomNavbar());
    });
  }
}
