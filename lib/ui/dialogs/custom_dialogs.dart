import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajal/controller/ui.controller.dart';
import 'package:provider/provider.dart';

class CustomDialogs {
  static showLoading() {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }

  static dismissLoading() {
    EasyLoading.dismiss();
  }

  static showToast(String title,
      {EasyLoadingToastPosition toastPosition =
          EasyLoadingToastPosition.center}) {
    EasyLoading.showToast(title,
        dismissOnTap: false, toastPosition: toastPosition);
  }

  static showWalletAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              child: Text(
            'Please verify your mobile number to activate you wallet.',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          )),
          title: Center(
            child: Text(
              'Verify Your Mobile',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
          actions: [
            MaterialButton(
              color: Colors.green,
              minWidth: 0,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<UiController>(context, listen: false)
                    .changeNavbarIndex(3);
              },
              child: const Text(
                'Verify',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              minWidth: 0,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
