import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/models/wallet_details_model.dart';
import 'package:janajal/services/api_calls.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/screens/main_widget.dart';
import 'package:janajal/utils/api_body.dart';
import 'package:janajal/utils/apis.dart';
import 'package:provider/provider.dart';

class WalletServices {
  static Future<WalletDetailModel?> getWalletDetails(
      BuildContext context) async {
    WalletDetailModel? walletDetailModel;
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStateList,
          body: ApiBody.getWalletDetailsBody(
            '118@$username',
            password!,
          ),
          context: context);
      List walletList = jsonDecode(
          data['S:Envelope']['S:Body']['ns2:walletListResponse']['return']);

      if (walletList.isNotEmpty) {
        walletDetailModel = WalletDetailModel.fromJson(walletList[0]);

        Provider.of<AuthController>(context, listen: false)
            .changeWalletDetailsModel(walletDetailModel);
      } else {
        CustomDialogs.showWalletAlertDialog(context);
      }

      return walletDetailModel;
    } catch (e) {
      print('$e erron in ${Apis.walletList} service');
      return null;
    }
  }

  static Future<List> getWalletTxnList(BuildContext context) async {
    try {
      List jsonListData = [];
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      String? walletNo = Provider.of<AuthController>(context, listen: false)
          .getWalletDetails!
          .walletNo;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body: ApiBody.getWalletTxnListBody(
              '118@$username', password!, walletNo!),
          context: context);
      jsonListData = jsonDecode(data['S:Envelope']['S:Body']
          ['ns2:processUsageWalletListResponse']['return']);
      return jsonListData;
    } catch (e) {
      print('$e erron in ${Apis.walletList} service');
      return [];
    }
  }

  static Future<List> getWalletTopUpList(BuildContext context) async {
    try {
      List jsonListData = [];
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      String? walletNo = Provider.of<AuthController>(context, listen: false)
          .getWalletDetails!
          .walletNo;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body: ApiBody.getWalletTopUpListBody(
              '118@$username', password!, walletNo!),
          context: context);
      jsonListData = jsonDecode(data['S:Envelope']['S:Body']
          ['ns2:processWalletRechargeListResponse']['return']);
      return jsonListData;
    } catch (e) {
      print('$e erron in ${Apis.walletList} service');
      return [];
    }
  }

  static Future<bool> saveWalletRecharge(
    BuildContext context,
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
      String? walletNo = Provider.of<AuthController>(context, listen: false)
          .getWalletDetails!
          .walletNo;
      print(walletNo);
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body: ApiBody.saveWalletRecharge(
            '118@$username',
            password!,
            amount,
            discountAmt,
            promo,
            txnId,
            walletNo!,
          ),
          context: context);

      if (data['S:Envelope']['S:Body']['ns2:saveWalletRechargeResponse']
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
      String? walletNo = Provider.of<AuthController>(context, listen: false)
          .getWalletDetails!
          .walletNo;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body: ApiBody.updateWalletRechargeBody(
            walletNo!,
            amount,
            '118@$username',
            password!,
            discountAmt,
            promo,
            txnId,
          ),
          context: context);
      print(data);
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>");
      if (data['S:Envelope']['S:Body']['ns2:updateWalletRechargeResponse']
              ['return'] ==
          '1') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: ((context) => MainWidget(
                      showToast: true,
                      toastString: 'Wallet Recharge Successful',
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
