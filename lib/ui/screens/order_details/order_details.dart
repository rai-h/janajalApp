import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:janajal/models/order_details_model.dart';
import 'package:janajal/services/wow_service.dart';
import 'package:janajal/ui/screens/maps_screen/maps_screen.dart';
import 'package:janajal/utils/janajal.dart';

class OrderDetails extends StatefulWidget {
  final String tripCode;
  final String status;
  final String txnId;
  const OrderDetails(
      {Key? key,
      required this.tripCode,
      required this.status,
      required this.txnId})
      : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  OrderDetailsModel? _orderDetailsModel = OrderDetailsModel();
  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    _orderDetailsModel = await WOWServiece.getOrderDetails(context, '59');
    print(_orderDetailsModel!.orderNo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios_new_sharp)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'My Order',
          style: TextStyle(
              fontSize: 24,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: widget.tripCode != 'NA'
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => LocationTracking(
                          wowId: _orderDetailsModel!.wowId ?? "",
                          wowLatLng: LatLng(
                            double.parse(_orderDetailsModel!.wowLat ?? "0.0"),
                            double.parse(_orderDetailsModel!.wowLong ?? "0.0"),
                          ),
                          destinationLatLng: LatLng(
                            double.parse(_orderDetailsModel!.latitude ?? "0.0"),
                            double.parse(
                                _orderDetailsModel!.longtitude ?? "0.0"),
                          ),
                        ))));
              },
              label: Text(
                'Track Order',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
          : null,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Details ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      _orderDetailsModel!.orderNo ?? " ",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trip Code: ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      widget.tripCode,
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      widget.status,
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Address ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      _orderDetailsModel!.address ?? "",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Driver Name ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      _orderDetailsModel!.driverName ?? "",
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction Id ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      widget.txnId,
                      style: TextStyle(
                          overflow: TextOverflow.visible,
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
