import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janajal/models/delivery_address_model.dart';
import 'package:janajal/services/address_service.dart';
import 'package:janajal/services/wow_service.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:janajal/ui/screens/place_order_screen/widget.dart';
import 'package:janajal/ui/screens/review_order_screen/review_order_screen.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:janajal/utils/validator.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  int? selectedAdd;
  List<DeliveryAddressModel> addressList = [];
  String? selectedDeliveryWindow;

  TextEditingController _qtyController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime? selectedDateTime;

  String _amountErrorText = '';
  String _deliveryDateErrorText = '';
  String _deliveryWindowErrorText = '';
  String _addressErrorText = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        print(picked);
        selectedDateTime = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  callApi() async {
    addressList = await AddressServices.getAddressList(context);
    setState(() {});
  }

  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  bool validate() {
    _amountErrorText = Validator.validateQuantity(_qtyController.text);

    if (_dateController.text.length == 0) {
      _deliveryDateErrorText = 'Please choose a Delivery Date';
    } else {
      _deliveryDateErrorText = '';
      _deliveryWindowErrorText = validateDeliveryWindow();
    }

    if (selectedAdd == null) {
      _addressErrorText = 'Please choose a Delivery Address';
    } else {
      _addressErrorText = '';
    }
    setState(() {});
    if (_amountErrorText.isEmpty &&
        _deliveryDateErrorText.isEmpty &&
        _deliveryWindowErrorText.isEmpty &&
        _addressErrorText.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String validateDeliveryWindow() {
    DateTime now = DateTime.now();
    Map<String, int> window = Janajal.deliveryWindow;
    List<String> windowKeys = Janajal.deliveryWindow.keys.toList();

    DateTime slot9Am = DateTime(now.year, now.month, now.day, 8, 35).toLocal();
    DateTime slot11Am =
        DateTime(now.year, now.month, now.day, 10, 35).toLocal();
    DateTime slot1Pm = DateTime(now.year, now.month, now.day, 12, 35).toLocal();
    DateTime slot3Pm = DateTime(now.year, now.month, now.day, 14, 35).toLocal();
    DateTime slot5Pm = DateTime(now.year, now.month, now.day, 16, 35).toLocal();

    if (selectedDateTime!
        .isAtSameMomentAs(DateTime(now.year, now.month, now.day).toLocal())) {
      if (now.isAfter(slot5Pm) &&
          window[selectedDeliveryWindow] == window[windowKeys[4]]) {
        return "You can't place order for this slot now. Please choose a different time date.";
      }
      if (now.isAfter(slot9Am) &&
          window[selectedDeliveryWindow] == window[windowKeys[0]]) {
        return "You can't place order for this slot now. Please choose a different time date.";
      }

      if (now.isAfter(slot11Am) &&
          window[selectedDeliveryWindow] == window[windowKeys[1]]) {
        return "You can't place order for this slot now. Please choose a different time date.";
      }
      if (now.isAfter(slot1Pm) &&
          window[selectedDeliveryWindow] == window[windowKeys[2]]) {
        return "You can't place order for this slot now. Please choose a different time date.";
      }
      if (now.isAfter(slot3Pm) &&
          window[selectedDeliveryWindow] == window[windowKeys[3]]) {
        return "You can't place order for this slot now. Please choose a different time date.";
      }
    } else {
      return 'Please select a delivery window';
    }

    return '';
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
      body: Container(
        height: size.height - 100,
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/backgroundOne.png',
                ),
                fit: BoxFit.fill)),
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                maxLength: 3,
                errorText: _amountErrorText,
                textInputType: TextInputType.number,
                controller: _qtyController,
                text: 'Amount (Ltrs)',
                prefixIcon: Icon(Icons.water_drop_rounded),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                enabled: true,
                readOnly: true,
                errorText: _deliveryDateErrorText,
                controller: _dateController,
                text: 'Delivery Date',
                onTap: () async {
                  await _selectDate(context);
                },
                prefixIcon: Icon(Icons.calendar_month_rounded),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      "Select Delivery Window",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.grey.shade400),
                    ),
                    items: Janajal.deliveryWindow.keys
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Colors.grey.shade700),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedDeliveryWindow,
                    onChanged: (value) {
                      setState(() {
                        selectedDeliveryWindow = value;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    buttonPadding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade50),
                    buttonElevation: 4,
                    itemHeight: 35,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownPadding: null,
                    dropdownFullScreen: true,
                    selectedItemHighlightColor: Colors.blue.shade100,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey.shade100,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
              _deliveryWindowErrorText.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _deliveryWindowErrorText,
                            style: TextStyle(color: Colors.red),
                          )),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Select Address',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.grey.shade700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _addressErrorText.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _addressErrorText,
                            style: TextStyle(color: Colors.red),
                          )),
                    )
                  : Container(),
              Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: addressList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAdd = index;
                            });
                          },
                          child: AddressBox(
                            isSelected: selectedAdd == index,
                            deliveryAddressModel: addressList[index],
                          ),
                        ),
                      );
                    }),
              ),
              MaterialButton(
                minWidth: size.width * 0.7,
                elevation: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onPressed: () async {
                  print(_dateController.text);
                  if (validate()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReviewOrderScreen(
                              date: _dateController.text,
                              deliveryAddressModel: addressList[selectedAdd!],
                              deliveryWindow: selectedDeliveryWindow!,
                              quntity: _qtyController.text,
                            )));
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                color: Colors.blue.shade900,
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
