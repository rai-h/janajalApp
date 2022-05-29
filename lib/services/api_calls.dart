import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/utils/apis.dart';
import 'package:xml2json/xml2json.dart';

import 'package:http/http.dart' as http;

class ApiCalls {
  static Xml2Json xml2json = new Xml2Json();
  static Future<dynamic> postCall({
    required String methodName,
    required String body,
    required BuildContext context,
  }) async {
    Map<String, String> headerData = new Map();
    Map<String, dynamic> responseData = {};
    String url = Apis.baseURL;
    headerData.putIfAbsent("Content-Type", () => "text/xml; charset=utf-8");
    headerData.putIfAbsent("SOAPAction", () => methodName);
    headerData.putIfAbsent("Host", () => "www.janajal.com");
    CustomDialogs.showLoading();
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: body, headers: headerData);
      print('response Body---> ${response.body}');
      print('response StatusCode---> ${response.statusCode}');
      if (response.statusCode == 200) {
        xml2json.parse(response.body);
        String jsonData = xml2json.toParker();
        responseData = json.decode(jsonData);
      }
      CustomDialogs.dismissLoading();
      return responseData;
    } catch (e) {
      CustomDialogs.dismissLoading();
      CustomDialogs.showToast('Oops!\nSomething Went Wrong');
      print("apiPostCall : $methodName has Error\n $e \n");
    }
    CustomDialogs.dismissLoading();
    return responseData;
  }
}
