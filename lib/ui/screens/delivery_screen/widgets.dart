import 'package:flutter/material.dart';
import 'package:janajal/controller/order.controller.dart';
import 'package:janajal/controller/ui.controller.dart';
import 'package:janajal/services/wow_service.dart';
import 'package:provider/provider.dart';

class DeliveryPageIndicator extends StatefulWidget {
  const DeliveryPageIndicator({Key? key}) : super(key: key);

  @override
  State<DeliveryPageIndicator> createState() => _DeliveryPageIndicatorState();
}

class _DeliveryPageIndicatorState extends State<DeliveryPageIndicator> {
  List<dynamic> orderList = [];
  @override
  void initState() {
    WOWServiece.getCurrentOrderListList(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UiController, OrderController>(
        builder: (context, notifier, orderNotifier, _) {
      return Material(
        elevation: 4,
        color: Colors.lightBlue.shade100.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  notifier.changeDeliveryTab(0, context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: notifier.selectedDeliveryTab == 0
                          ? Colors.blue.shade900
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        'Current',
                        style: TextStyle(
                            fontSize: 16,
                            color: notifier.selectedDeliveryTab == 0
                                ? Colors.white
                                : Colors.blue.shade900,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  notifier.changeDeliveryTab(1, context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: notifier.selectedDeliveryTab == 1
                          ? Colors.blue.shade900
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        'Previous',
                        style: TextStyle(
                            fontSize: 16,
                            color: notifier.selectedDeliveryTab == 1
                                ? Colors.white
                                : Colors.blue.shade900,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  notifier.changeDeliveryTab(2, context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: notifier.selectedDeliveryTab == 2
                          ? Colors.blue.shade900
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        'Cancelled',
                        style: TextStyle(
                            fontSize: 16,
                            color: notifier.selectedDeliveryTab == 2
                                ? Colors.white
                                : Colors.blue.shade900,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class OrderCard extends StatelessWidget {
  final String date;
  final String deliveryWindow;
  final String orderNo;
  final String amount;
  final String txnId;
  final String quantity;
  OrderCard({
    Key? key,
    this.date = '',
    this.amount = '',
    this.deliveryWindow = '',
    this.orderNo = '',
    this.quantity = '',
    this.txnId = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.6),
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderNo,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  date,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Amount: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      amount,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Quantity: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      quantity,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Delivery Window: ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  deliveryWindow,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Transaction Id: ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  txnId,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
