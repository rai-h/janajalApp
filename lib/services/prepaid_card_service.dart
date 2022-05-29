import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/services/api_calls.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/screens/main_widget.dart';
import 'package:janajal/utils/api_body.dart';
import 'package:janajal/utils/apis.dart';
import 'package:provider/provider.dart';

class PrepaidCardServices {
  static Future<List<dynamic>> getPrepaidCardList(BuildContext context) async {
    String? username =
        Provider.of<AuthController>(context, listen: false).getUserName;
    String? password =
        Provider.of<AuthController>(context, listen: false).getPassword;
    try {
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body: ApiBody.getPPCardsBody('118@$username', password!),
          context: context);
      print(jsonDecode(
          data['S:Envelope']['S:Body']['ns2:cardListResponse']['return']));
      return jsonDecode(
          data['S:Envelope']['S:Body']['ns2:cardListResponse']['return']);
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<dynamic>> getPrepaicardTxnList(
      BuildContext context, String cardNo) async {
    String? username =
        Provider.of<AuthController>(context, listen: false).getUserName;
    String? password =
        Provider.of<AuthController>(context, listen: false).getPassword;
    try {
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body:
              ApiBody.getPPCardTxnListBody('118@$username', password!, cardNo),
          context: context);
      print(data);
      return jsonDecode(data['S:Envelope']['S:Body']
          ['ns2:processUsageCardListResponse']['return']);
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<dynamic>> getPrepaicardTopUpList(
      BuildContext context, String cardNo) async {
    String? username =
        Provider.of<AuthController>(context, listen: false).getUserName;
    String? password =
        Provider.of<AuthController>(context, listen: false).getPassword;
    try {
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body: ApiBody.getPPCardPopUpListBody(
              '118@$username', password!, cardNo),
          context: context);
      print(data);
      return jsonDecode(data['S:Envelope']['S:Body']
          ['ns2:processRechargeCardListResponse']['return']);
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<bool> saveWalletRecharge(
    BuildContext context,
    String cardNo,
    String amount,
    String discountAmt,
    String promo,
    String txnId,
  ) async {
    try {
      List jsonListData = [];
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body: ApiBody.savePrepaidCardRecharge(
            '118@$username',
            password!,
            amount,
            discountAmt,
            promo,
            txnId,
            cardNo,
          ),
          context: context);

      if (data['S:Envelope']['S:Body']['ns2:saveCardRechargeResponse']
              ['return'] ==
          '1') {
        return true;
      }
      CustomDialogs.showToast('Something went Wrong');
      return false;
    } catch (e) {
      print('$e erron in ${Apis.walletList} service');
      CustomDialogs.showToast('Something went Wrong');
      return false;
    }
  }

  static Future<bool> updateWalletRechargeBody(
    BuildContext context,
    String cardNo,
    String amount,
    String discountAmt,
    String promo,
    String txnId,
  ) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body: ApiBody.updatPrepaidCardRechargeBody(
            cardNo,
            amount,
            '118@$username',
            password!,
            discountAmt,
            promo,
            txnId,
          ),
          context: context);

      if (data['S:Envelope']['S:Body']['ns2:updateCardRechargeResponse']
              ['return'] ==
          '1') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: ((context) => MainWidget(
                      showToast: true,
                      toastString: 'Card Recharge Successful',
                    ))),
            (route) => false);
        return true;
      }

      return false;
    } catch (e) {
      print('$e erron in ${Apis.walletList} service');
      CustomDialogs.showToast('Something went Wrong');
      return false;
    }
  }
}
