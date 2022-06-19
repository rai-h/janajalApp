import 'package:flutter/cupertino.dart';

class OrderController extends ChangeNotifier {
  List<dynamic> _orderList = [];
  List<dynamic> get getOrderList => _orderList;

  changeOrderList(List<dynamic> orderList) async {
    _orderList = orderList;
    notifyListeners();
  }
}
