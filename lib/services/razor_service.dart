import 'dart:convert';

import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class RazorPayServices {
  static final razorpayInstance = Razorpay();

  static final headers = {"Content-Type": "application/json"};

  static Map<String, dynamic> createOption(
      double amount,
      String name,
      String description,
      String phone,
      String email,
      String txnId,
      String orderId) {
    return {
      'order_id': orderId,
      'key': RazorPayKey.LIVE_KEY,
      'amount': amount * 100,
      'name': name,
      'prefill': {'contact': phone, 'email': email}
    };
  }

  static Future<String> generateOrder(double amount, String txnId) async {
    String username = RazorPayKey.LIVE_KEY;
    print(amount);
    String password = RazorPayKey.LIVE_SECERET_KEY;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    Map<String, dynamic> option = {
      "amount": amount * 100,
      "currency": "INR",
      "receipt": "order_rcptid_$txnId",
    };

    try {
      http.Response response = await http.post(
        Uri.parse("https://api.razorpay.com/v1/orders"),
        body: jsonEncode(option),
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['id'];
      }
      CustomDialogs.showToast('Something went wrong');
      return '';
    } catch (e) {
      CustomDialogs.showToast('$e');
      return '';
    }
  }
}
