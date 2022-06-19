import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/models/offer_model.dart';
import 'package:janajal/models/wallet_details_model.dart';
import 'package:janajal/services/api_calls.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/screens/main_widget.dart';
import 'package:janajal/utils/api_body.dart';
import 'package:janajal/utils/apis.dart';
import 'package:janajal/utils/shared_pref.dart';
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
        // CustomDialogs.showWalletAlertDialog(context);
      }

      return walletDetailModel;
    } catch (e) {
      print('$e erron in ${Apis.walletList} service getwallet details');
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
            40.toString(),
            promo,
            txnId,
            walletNo!,
          ),
          context: context);
      String dataString = data['S:Envelope']['S:Body']
          ['ns2:saveWalletRechargeResponse']['return'];
      if (dataString.toLowerCase().contains('Invalid Amount'.toLowerCase())) {
        CustomDialogs.showToast('Invalid Amount');
        return false;
      }
      if (dataString.toLowerCase().contains('Invalid Promo'.toLowerCase())) {
        CustomDialogs.showToast('Invalid Promo');
        return false;
      }
      if (dataString.toLowerCase().contains('Already used'.toLowerCase())) {
        CustomDialogs.showToast('Promo Already Used');
        return false;
      }
      if (dataString == '1') {
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

  static Future<bool> checkPromo(
    BuildContext context,
    String discount,
    String amount,
    String promo,
  ) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body: ApiBody.checkPromoBody(
            '118@$username',
            password!,
            promo,
            amount,
          ),
          context: context);
      String dataString = data['S:Envelope']['S:Body']['ns2:checkPromoResponse']
              ['return']
          .toString();

      if (dataString == discount) {
        return true;
      }
      if (dataString == '1') {
        CustomDialogs.showToast('Validity Expired for this Promo Code');
        return false;
      }
      if (dataString == '2') {
        CustomDialogs.showToast('PromoCode is not valid.');
        return false;
      }
      if (dataString == 'Invalid Amount for this Promo') {
        CustomDialogs.showToast('Invalid Amount for this Promo');
        return false;
      }

      CustomDialogs.showToast('Something went Wrong');
      return false;
    } catch (e) {
      print('$e erron in ${Apis.walletList} service');
      CustomDialogs.showToast('Something went Wrong');
      return false;
    }
  }

  static Future<List<OffersModel>> getOfferList(
    BuildContext context,
  ) async {
    List<OffersModel> offerModelList = [];
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.processUsageWalletList,
          body: ApiBody.getOfferList(
            '118@$username',
            password!,
          ),
          showLoading: false,
          context: context);
      String dataString = data['S:Envelope']['S:Body']
              ['ns2:getPromoListResponse']['return']
          .toString();
      print(dataString);
      if (dataString.isNotEmpty) {
        jsonDecode(dataString).forEach((element) {
          offerModelList.add(OffersModel.fromJson(element));
        });
        Provider.of<AuthController>(context, listen: false)
            .changeOfferModelList(offerModelList);
        String offerTimeStamp = (await SharedPref.getOfferShownTime());
        if (offerTimeStamp.isNotEmpty) {
          if ((DateTime.now().millisecondsSinceEpoch -
                  int.parse(offerTimeStamp) >
              86400000)) {
            CustomDialogs.showOfferListDialog(context, offerModelList);
          }
        } else {
          CustomDialogs.showOfferListDialog(context, offerModelList);
        }
        return offerModelList;
      }

      return offerModelList;
    } catch (e) {
      print('$e erron in offlist service');
      CustomDialogs.showToast('Something went Wrong in promo');
      return offerModelList;
    }
  }
}
