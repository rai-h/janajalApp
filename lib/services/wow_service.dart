import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/controller/order.controller.dart';
import 'package:janajal/models/order_details_model.dart';
import 'package:janajal/services/api_calls.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/screens/home_screen/home_screen.dart';
import 'package:janajal/ui/screens/main_widget.dart';
import 'package:janajal/ui/screens/order_details/order_details.dart';
import 'package:janajal/utils/api_body.dart';
import 'package:janajal/utils/apis.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class WOWServiece {
  static Xml2Json xml2json = new Xml2Json();
  static Future<List<dynamic>> getCurrentOrderListList(
    BuildContext context,
  ) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.getCurrentOrderListVBody(
            '118@$username',
            password!,
          ),
          context: context);
      Provider.of<OrderController>(context, listen: false).changeOrderList(
          jsonDecode(data['S:Envelope']['S:Body']
              ['ns2:getCurrentOrderListResponse']['return']));
      return jsonDecode(data['S:Envelope']['S:Body']
          ['ns2:getCurrentOrderListResponse']['return']);
    } catch (e) {
      print('$e erron in service');
      return [];
    }
  }

  static Future<List<dynamic>> getPreviousOrderListList(
    BuildContext context,
  ) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.getPreviousOrderListVBody(
            '118@$username',
            password!,
          ),
          context: context);
      Provider.of<OrderController>(context, listen: false).changeOrderList(
          jsonDecode(data['S:Envelope']['S:Body']
              ['ns2:getPreviousOrderListResponse']['return']));
      return jsonDecode(data['S:Envelope']['S:Body']
          ['ns2:getPreviousOrderListResponse']['return']);
    } catch (e) {
      print('$e erron in service');
      return [];
    }
  }

  static Future<List<dynamic>> getCancelOrderListList(
    BuildContext context,
  ) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.getCancelOrderListVBody(
            '118@$username',
            password!,
          ),
          context: context);

      Provider.of<OrderController>(context, listen: false).changeOrderList(
          jsonDecode(data['S:Envelope']['S:Body']
              ['ns2:getCancelOrderListResponse']['return']));
      return jsonDecode(data['S:Envelope']['S:Body']
          ['ns2:getCancelOrderListResponse']['return']);
    } catch (e) {
      print('$e erron in service');
      return [];
    }
  }

  static Future<String> saveOrder(
      BuildContext context,
      String amount,
      String locId,
      String address,
      String deliveryWindow,
      String deliveryDate,
      String pincode,
      String qty,
      String txnId) async {
    String consignmentNo = '';
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.saveOrderBody('118@$username', password!, amount, locId,
              address, deliveryWindow, deliveryDate, pincode, qty, txnId),
          context: context);
      consignmentNo = data['S:Envelope']['S:Body']
          ['ns2:saveConsignmentOrderResponse']['return'];
      if (consignmentNo.length == 0) {
        CustomDialogs.showToast('Something went wrong');
      }
      return consignmentNo;
    } catch (e) {
      print('$e erron in service');
      return '';
    }
  }

  static Future<String> getOrderRate(
    BuildContext context,
    String pincode,
  ) async {
    String orderRate = '';
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.getOrderRateBody(
            '118@$username',
            password!,
            pincode,
          ),
          context: context);
      orderRate =
          data['S:Envelope']['S:Body']['ns2:getOrderRateResponse']['return'];
      if (orderRate.length == 0 && orderRate == null) {
        CustomDialogs.showToast('Something went wrong');
      }
      return orderRate;
    } catch (e) {
      print('$e erron in service');
      return '';
    }
  }

  static Future<String> updateOrderPayment(BuildContext context,
      {required String amount,
      required String locId,
      required String qty,
      required String consignmentNo,
      required String txnId}) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.updateOrderPaymentBody(
            '118@$username',
            password!,
            locId,
            consignmentNo,
            amount,
            qty,
            txnId,
          ),
          context: context);
      print(data);
      if (data['S:Envelope']['S:Body']['ns2:updateOrderPaymentResponse']
              ['return'] !=
          '1') {
        CustomDialogs.showToast('Something went wrong');
      } else {
        CustomDialogs.showToast('Order $consignmentNo created successfully');
        await Future.delayed(Duration(milliseconds: 1600));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: ((context) => MainWidget(
                      showToast: true,
                      toastString: 'Order $consignmentNo created successfully',
                    ))),
            (route) => false);
      }
      return consignmentNo;
    } catch (e) {
      print('$e erron in service');
      return '';
    }
  }

  static Future<bool?> saveOrderWithWallet(BuildContext context, String orderId,
      String amount, String walletId) async {
    OrderDetailsModel? orderDetailsModel;
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.getWalletOrderBody(
            '118@$username',
            password!,
            amount,
            orderId,
            walletId,
          ),
          context: context);
      print(data['S:Envelope']['S:Body']['ns2:saveQRDataResponse']['return']
          .runtimeType);
      if (double.tryParse(data['S:Envelope']['S:Body']['ns2:saveQRDataResponse']
                      ['return']
                  .toString())
              .runtimeType ==
          double) {
        return true;
      }
      return false;
    } catch (e) {
      print('$e erron in service');
      return false;
    }
  }

  static Future<OrderDetailsModel?> getOrderDetails(
    BuildContext context,
    String orderId,
  ) async {
    OrderDetailsModel? orderDetailsModel;
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.getOrderDetailsBody(
            '118@$username',
            password!,
            orderId,
          ),
          context: context);

      orderDetailsModel = OrderDetailsModel.fromJson(jsonDecode(
          data['S:Envelope']['S:Body']['ns2:getOrderDetailsResponse']
              ['return']));
      if (orderDetailsModel == null) {
        CustomDialogs.showToast('Something went wrong');
      }
      return orderDetailsModel;
    } catch (e) {
      print('$e erron in service');
      return orderDetailsModel;
    }
  }

  static Future<LatLng?> getWowLocation(
      BuildContext context, String wowId) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;
      Map<String, String> headerData = new Map();
      Map<String, dynamic> responseData = {};
      String url = Apis.baseURL;
      headerData.putIfAbsent("Content-Type", () => "text/xml; charset=utf-8");
      headerData.putIfAbsent("SOAPAction", () => 'getWOWLatLng');
      headerData.putIfAbsent("Host", () => "www.janajal.com");

      http.Response response = await http.post(Uri.parse(url),
          body: ApiBody.getWowLocationBody(username!, password!, wowId),
          headers: headerData);
      print('response Body---> ${response.body}');
      print('response StatusCode---> ${response.statusCode}');
      if (response.statusCode == 200) {
        xml2json.parse(response.body);
        String jsonData = xml2json.toParker();
        responseData = json.decode(jsonData);
      }
      String data = responseData['S:Envelope']['S:Body']
          ['ns2:getWOWLatLngResponse']['return'];
      if (data.isEmpty) {
        return null;
      }
      return LatLng(
          double.parse(data.split(',')[0]), double.parse(data.split(',')[1]));
    } catch (e) {
      print(e);
    }
  }

  static Future<void> saveOrderRating(
    BuildContext context,
    String orderId,
    String ratingLevel,
    String remarks,
    String personType,
  ) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.saveRatings('118@$username', password!, orderId,
              ratingLevel, remarks, personType),
          context: context);
      print(data);
      String result = data['S:Envelope']['S:Body']['ns2:saveRatingsResponse']
              ['return']
          .toString();
      if (result == '1') {
        Navigator.of(context).pop();
        CustomDialogs.showToast("Saved");
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<Map<String, dynamic>> getWOWData(String wowId) async {
    Map<String, dynamic> data = {};
    String url =
        'https://7u2ig7u4k8.execute-api.ap-south-1.amazonaws.com/prod/ohiya/water/wts?uid=${wowId}';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'auth-token': 'MNW9hrnpRX',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        if (data['code'] == 200) {
          return data['data'];
        }
      }

      return {};
    } catch (e) {
      print(e);
      return {};
    }
  }
}
