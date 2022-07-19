import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:janajal/models/delivery_address_model.dart';

class AddressBox extends StatefulWidget {
  final bool isSelected;
  final DeliveryAddressModel deliveryAddressModel;
  const AddressBox(
      {Key? key, this.isSelected = false, required this.deliveryAddressModel})
      : super(key: key);

  @override
  State<AddressBox> createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  @override
  void initState() {
    print(widget.deliveryAddressModel.city);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
            children: [
              Text(
                'my_order_screnn.address'.tr() + " : ",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Text(
                  (widget.deliveryAddressModel.area ?? "") +
                      ',' +
                      (widget.deliveryAddressModel.city ?? "") +
                      ',' +
                      (widget.deliveryAddressModel.stateName ?? "") +
                      '-' +
                      (widget.deliveryAddressModel.pincode.toString()),
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
            children: [
              Text(
                'my_order_screnn.landmark'.tr() + " : ",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Text(
                  widget.deliveryAddressModel.landMark ?? " ",
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 14,
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
            children: [
              Text(
                'my_order_screnn.delivery_point'.tr() + " : ",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Text(
                  widget.deliveryAddressModel.deliveryPoint ?? "",
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: widget.isSelected
                ? const Icon(
                    Icons.check_circle_outlined,
                    size: 40,
                    color: Colors.green,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
