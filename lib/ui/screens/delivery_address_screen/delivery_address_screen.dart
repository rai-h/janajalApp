import 'package:flutter/material.dart';
import 'package:janajal/models/delivery_address_model.dart';
import 'package:janajal/services/address_service.dart';
import 'package:janajal/ui/screens/delivery_address_screen/widget.dart';
import 'package:janajal/ui/screens/edit_location_screen/edit_location_screen.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  List<DeliveryAddressModel> addressList = [];

  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    addressList = await AddressServices.getAddressList(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
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
              'Your Addresses',
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
            child: ListView.builder(
                itemCount: addressList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: AddressWidget(
                      deliveryAddressModel: addressList[index],
                    ),
                  );
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
              minWidth: size.width * 0.7,
              elevation: 10,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditLocationScreen(),
                ));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              color: Colors.blue.shade900,
              child: const Text(
                'Add New Location',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
