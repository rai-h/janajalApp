import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:janajal/services/address_service.dart';
import 'package:janajal/services/auth_service.dart';
import 'package:janajal/ui/helping_widget/custom_dropdown.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:janajal/ui/helping_widget/round_button.dart';
import 'package:janajal/ui/screens/edit_location_screen/address_map_screen.dart';
import 'package:janajal/ui/screens/login_screen/widget.dart';
import 'package:janajal/utils/validator.dart';

class EditLocationScreen extends StatefulWidget {
  const EditLocationScreen({Key? key}) : super(key: key);

  @override
  State<EditLocationScreen> createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  TextEditingController _addressContrller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _landMarkController = TextEditingController();
  TextEditingController _deliveryPointController = TextEditingController();
  String? state;
  String? stateId;
  Map<String, dynamic>? selectedState;

  List<Map<String, dynamic>> stateList = [];

  String addressErrorText = '';
  String cityErrorText = '';
  String stateErrorText = '';
  String pincodeErrorText = '';
  String landMarkErrorText = '';
  String deliveryErrorText = '';

  validateForm() async {
    addressErrorText = '';
    cityErrorText = '';
    stateErrorText = '';
    pincodeErrorText = '';
    landMarkErrorText = '';
    deliveryErrorText = '';
    if (_addressContrller.text.isEmpty) {
      addressErrorText = 'Please enter a address';
    }
    if (_cityController.text.isEmpty) {
      cityErrorText = 'Please enter a city';
    }
    if (state == null) {
      stateErrorText = 'Please select a state';
    }
    pincodeErrorText = Validator.validatePincode(_pincodeController.text);
    if (pincodeErrorText.isEmpty) {
      pincodeErrorText = await Validator.checkPincodeForDelivery(
          context, _pincodeController.text);
    }
    if (_landMarkController.text.isEmpty) {
      landMarkErrorText = 'Please enter a land mark';
    }
    if (_deliveryPointController.text.isEmpty) {
      deliveryErrorText = 'Please enter a delivery point';
    }
    print(addressErrorText.isNotEmpty &&
        cityErrorText.isNotEmpty &&
        stateErrorText.isNotEmpty &&
        pincodeErrorText.isNotEmpty &&
        landMarkErrorText.isNotEmpty &&
        deliveryErrorText.isNotEmpty);

    print(addressErrorText.isNotEmpty);

    if (addressErrorText.isEmpty &&
        cityErrorText.isEmpty &&
        stateErrorText.isEmpty &&
        pincodeErrorText.isEmpty &&
        landMarkErrorText.isEmpty &&
        deliveryErrorText.isEmpty) {
      setState(() {});
      return true;
    }
    setState(() {});
    return false;
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  callApi() async {
    stateList = await AddressServices.getStatePointDetails(context);
    setState(() {});
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
          'Add Location',
          style: TextStyle(
              fontSize: 24,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        height: size.height - 100,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/backgroundOne.png',
                ),
                fit: BoxFit.fill)),
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  maxLines: 2,
                  text: 'Address*',
                  controller: _addressContrller,
                  errorText: addressErrorText,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  text: 'City*',
                  controller: _cityController,
                  errorText: cityErrorText,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<Map<String, dynamic>>(
                          isExpanded: true,
                          hint: Text(
                            'State',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.grey.shade400),
                          ),
                          items: stateList
                              .map((item) =>
                                  DropdownMenuItem<Map<String, dynamic>>(
                                    value: item,
                                    child: Text(
                                      item['stateName'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: Colors.grey.shade500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedState,
                          onChanged: (value) {
                            setState(() {
                              selectedState = value;
                              state = value!['stateName'];
                              stateId = value['stateId'];
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
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
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
                      stateErrorText.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    stateErrorText,
                                    style: TextStyle(color: Colors.red),
                                  )),
                            )
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  text: 'Pincode*',
                  maxLength: 6,
                  controller: _pincodeController,
                  errorText: pincodeErrorText,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  text: 'Land Mark*',
                  controller: _landMarkController,
                  errorText: landMarkErrorText,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  text: 'Delivery Point*',
                  controller: _deliveryPointController,
                  errorText: deliveryErrorText,
                ),
                SizedBox(
                  height: 20,
                ),
                RoundButton(
                    onPress: () async {
                      print("object");
                      if (await validateForm()) {
                        print("object");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => AddressMapScreen(
                                  address: _addressContrller.text,
                                  city: _cityController.text,
                                  state: state!,
                                  pincode: _pincodeController.text,
                                  landMark: _landMarkController.text,
                                  deliveryPoint: _deliveryPointController.text,
                                  stateId: stateId!,
                                )),
                          ),
                        );
                      }
                    },
                    color: Colors.blue.shade900,
                    text: 'Locate on map'),
                SizedBox(
                  height: size.width * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
