import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:janajal/models/delivery_address_model.dart';
import 'package:janajal/services/address_service.dart';
import 'package:janajal/ui/screens/edit_location_screen/edit_location_screen.dart';
import 'package:janajal/utils/janajal.dart';

class AddressWidget extends StatefulWidget {
  final bool isSelected;
  final DeliveryAddressModel deliveryAddressModel;
  const AddressWidget(
      {Key? key, this.isSelected = false, required this.deliveryAddressModel})
      : super(key: key);

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
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
                width: size.width * 0.7,
                child: Text(
                  widget.deliveryAddressModel.area ?? " ",
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
                  widget.deliveryAddressModel.deliveryPoint ?? " ",
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                elevation: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditLocationScreen(
                      addressModel: widget.deliveryAddressModel,
                    ),
                  ));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                color: Janajal.secondaryColor,
                child: const Text(
                  'Edit',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              MaterialButton(
                elevation: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onPressed: () {
                  AddressServices.deleteAddress(context,
                      locId: widget.deliveryAddressModel.locId!);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                color: Colors.green.shade800,
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
