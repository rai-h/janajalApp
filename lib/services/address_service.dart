import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/models/delivery_address_model.dart';
import 'package:janajal/services/api_calls.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/screens/main_widget.dart';
import 'package:janajal/utils/api_body.dart';
import 'package:janajal/utils/apis.dart';
import 'package:provider/provider.dart';

class AddressServices {
  static Future<List<DeliveryAddressModel>> getAddressList(
    BuildContext context,
  ) async {
    List<DeliveryAddressModel> addressList = [];
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.getAddressListVBody(
            '118@$username',
            password!,
          ),
          context: context);
      jsonDecode(data['S:Envelope']['S:Body']['ns2:locationListResponse']
              ['return'])
          .forEach((element) {
        addressList.add(DeliveryAddressModel.fromJson(element));
        print(element);
      });

      return addressList;
    } catch (e) {
      print('$e erron in service');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getStatePointDetails(
    BuildContext context,
  ) async {
    List<Map<String, dynamic>> addressList = [];
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.getStatePointDetailsBody(
            '118@$username',
            password!,
          ),
          context: context);
      jsonDecode(data['S:Envelope']['S:Body']
              ['ns2:getStatePointDetailsResponse']['return'])
          .forEach((element) {
        addressList.add(element);
        // print(element);
      });

      return addressList;
    } catch (e) {
      print('$e erron in service');
      return [];
    }
  }

  static Future<bool> checkPicodeForDelivery(
      BuildContext context, String pincode) async {
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body:
              ApiBody.getCheckPincodeBody('118@$username', password!, pincode),
          context: context);

      if (jsonDecode(data['S:Envelope']['S:Body']['ns2:checkPincodeResponse']
              ['return']) ==
          int.parse(pincode)) {
        return true;
      }

      return false;
    } catch (e) {
      print('$e erron in service');
      return false;
    }
  }

  static Future<void> saveAddressList(BuildContext context,
      {required String city,
      required String area,
      required String landMark,
      required String pincode,
      required String stateId,
      required String locId,
      required String googleName,
      required String deliveryPoint,
      required String lat,
      required String long}) async {
    List<DeliveryAddressModel> addressList = [];
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.saveLocationBody(
              userName: '118@$username',
              password: password!,
              area: area,
              landMark: landMark,
              pincode: pincode,
              stateId: stateId,
              locId: locId,
              googleName: googleName,
              deliveryPoint: deliveryPoint,
              lat: lat,
              long: long,
              city: city),
          context: context);

      if (data['S:Envelope']['S:Body']['ns2:saveLocationResponse']['return']
              .toString() ==
          '1') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: ((context) => MainWidget(
                      showToast: true,
                      toastString: 'Address Saved',
                    ))),
            (route) => false);
      } else {
        CustomDialogs.showToast('Something went wrong');
      }
    } catch (e) {
      print('$e erron in service');
      CustomDialogs.showToast('Something went wrong');
    }
  }

  static Future<void> deleteAddress(
    BuildContext context, {
    required String locId,
  }) async {
    List<DeliveryAddressModel> addressList = [];
    try {
      String? username =
          Provider.of<AuthController>(context, listen: false).getUserName;
      String? password =
          Provider.of<AuthController>(context, listen: false).getPassword;

      Map<String, dynamic> data = await ApiCalls.postCall(
          methodName: Apis.getStationList,
          body: ApiBody.deleteLocationBody(
            userName: '118@$username',
            password: password!,
            locId: locId,
          ),
          context: context);

      if (data['S:Envelope']['S:Body']['ns2:deleteLocationResponse']['return']
              .toString() ==
          '1') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: ((context) => MainWidget(
                      showToast: true,
                      toastString: 'Address deleted',
                    ))),
            (route) => false);
      } else {
        CustomDialogs.showToast('Something went wrong');
      }
    } catch (e) {
      print('$e erron in service');
      CustomDialogs.showToast('Something went wrong');
    }
  }
}
