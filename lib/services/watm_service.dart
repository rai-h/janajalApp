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

class WatmServices {
  static Future<List<dynamic>> getStateList(BuildContext context) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStateList,
          body: ApiBody.getStateBody(
            context,
            '118@$username',
            password!,
          ),
          context: context);
      print(jsonDecode(data['S:Envelope']['S:Body']['ns2:getStateListResponse']
          ['return'])[0]);
      return jsonDecode(
          data['S:Envelope']['S:Body']['ns2:getStateListResponse']['return']);
    } catch (e) {
      print('$e erron in ${Apis.getStateList} service');
      return [];
    }
  }

  static Future<List<dynamic>> getCityList(
      BuildContext context, String clusterId) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStateList,
          body: ApiBody.getCityBody(
              context, '118@$username', password!, clusterId),
          context: context);
      print(jsonDecode(data['S:Envelope']['S:Body']
          ['ns2:getCityPointDetailsResponse']['return'])[0]);
      return jsonDecode(data['S:Envelope']['S:Body']
          ['ns2:getCityPointDetailsResponse']['return']);
    } catch (e) {
      print('$e erron in ${Apis.getStateList} service');
      return [];
    }
  }

  static Future<List<dynamic>> getStationList(
      BuildContext context, String cityName) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStateList,
          body: ApiBody.getStationListBody(
            '118@$username',
            password!,
            cityName,
          ),
          context: context);
      print(data);
      return jsonDecode(
          data['S:Envelope']['S:Body']['ns2:stationListResponse']['return']);
    } catch (e) {
      print('$e erron in ${Apis.getStateList} service');
      return [];
    }
  }

  static Future<void> saveQRData(
      BuildContext context, String amount, String deviceId) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStateList,
          body: ApiBody.getSaveQrBody(
              '118@$username', password!, amount, deviceId),
          context: context);
      int dataResp = jsonDecode(
          data['S:Envelope']['S:Body']['ns2:saveQRDataResponse']['return']);
      if (double.tryParse(data['S:Envelope']['S:Body']['ns2:saveQRDataResponse']
                      ['return']
                  .toString())
              .runtimeType ==
          double) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: ((context) => MainWidget(
                      showToast: true,
                      toastString: 'Payment Successful',
                    ))),
            (route) => false);
      } else if (dataResp == 100) {
        CustomDialogs.showToast('Not Enough Amount');
      } else if (dataResp == 200) {
        CustomDialogs.showToast('Wallet Not Found');
      } else {
        CustomDialogs.showToast('Transaction Failed');
      }
    } catch (e) {
      CustomDialogs.showToast('Transaction Failed');

      print('$e erron in ${Apis.getStateList} service');
    }
  }
}
