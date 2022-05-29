import 'package:flutter/material.dart';
import 'package:janajal/controller/order.controller.dart';
import 'package:janajal/controller/ui.controller.dart';
import 'package:janajal/services/address_service.dart';
import 'package:janajal/ui/screens/delivery_screen/widgets.dart';
import 'package:janajal/ui/screens/maps_screen/maps_screen.dart';
import 'package:janajal/ui/screens/order_details/order_details.dart';
import 'package:provider/provider.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'My Orders',
          style: TextStyle(
              fontSize: 30,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const DeliveryPageIndicator(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.74,
              child: Consumer2<OrderController, UiController>(
                  builder: (context, notifier, uiNotifier, _) {
                return ListView.builder(
                    itemCount: notifier.getOrderList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return notifier.getOrderList[index]['OrderNo'] !=
                              'No Order'
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) => OrderDetails(
                                          tripCode: notifier.getOrderList[index]
                                              ['TripCode'],
                                          status: notifier.getOrderList[index]
                                              ['Status'],
                                          txnId: notifier.getOrderList[index]
                                              ['txnId'],
                                        )),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: OrderCard(
                                  orderNo: getOrderInfoFromOrderString(notifier
                                      .getOrderList[index]['OrderNo'])[0],
                                  quantity: getOrderInfoFromOrderString(notifier
                                      .getOrderList[index]['OrderNo'])[1],
                                  amount: getOrderInfoFromOrderString(notifier
                                      .getOrderList[index]['OrderNo'])[2],
                                  date: notifier.getOrderList[index]
                                      ['orderDate'],
                                  deliveryWindow: notifier.getOrderList[0]
                                      ['deliveryWindow'],
                                  txnId: notifier.getOrderList[index]['txnId'],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: OrderCard(
                                orderNo: notifier.getOrderList[index]
                                    ['OrderNo'],
                                quantity: 'N/A',
                                amount: 'N/A',
                                date: notifier.getOrderList[index]['orderDate'],
                                deliveryWindow: notifier.getOrderList[0]
                                    ['deliveryWindow'],
                                txnId: notifier.getOrderList[index]['txnId'],
                              ),
                            );
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}

List<String> getOrderInfoFromOrderString(String data) {
  List<String> list = [];

  try {
    list.add(data.toString().substring(10, 23));
  } catch (e) {
    list.add('N/A');
  }
  try {
    list.add(data.substring(34, 44));
  } catch (e) {
    list.add('N/A');
  }
  try {
    list.add(data.toString().substring(55, 63));
  } catch (e) {
    list.add('N/A');
  }
  print(list);
  return list;
}
