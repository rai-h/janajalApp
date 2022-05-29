import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/helping_widget/round_button.dart';
import 'package:janajal/ui/screens/about_us_screen/about_us.dart';
import 'package:janajal/ui/screens/delivery_address_screen/delivery_address_screen.dart';
import 'package:janajal/ui/screens/faq_screen/faq_screen.dart';
import 'package:janajal/ui/screens/home_screen/widget.dart';
import 'package:janajal/ui/screens/place_order_screen/place_order_screen.dart';
import 'package:janajal/ui/screens/prepaid_card_screen/prepaid_card_screen.dart';
import 'package:janajal/ui/screens/qr_screen/qr_screen.dart';
import 'package:janajal/ui/screens/wallet_add_money_screen/wallet_add_money_screen.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:janajal/ui/screens/watm_locator_screen/watm_locator_screen.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:janajal/utils/validator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String deviceId = '';
  String extractDeviceId(String qrData) {
    int indexOfJJ = qrData.lastIndexOf('Janajal_');
    int indexOfSym = qrData.lastIndexOf('&');
    deviceId = qrData
        .substring(indexOfJJ + 'Janajal_'.length, indexOfSym)
        .toLowerCase();
    if (deviceId.contains('jj')) {
      int deviceNo =
          int.tryParse(deviceId.substring(2, deviceId.length - 2)) ?? 0;
      if (deviceNo > 220) {
        deviceId = deviceId.substring(0, 2) + '0' + deviceId.substring(2);
      } else {
        deviceId = deviceId.replaceAll("0", "");
      }
    }
    return deviceId.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Icon(
              Icons.location_on_rounded,
              size: 30,
              color: Colors.lightBlue,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Janajal',
                      style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.lightBlue,
                      size: 30,
                    )
                  ],
                ),
                Text(
                  'Noida',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CarouselWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  height: 70,
                  minWidth: 100,
                  color: Colors.purple.shade900,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500)),
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WatmLocatorScree(),
                    ));
                  }),
                  child: Column(
                    children: [
                      Icon(
                        Icons.assistant_navigation,
                        color: Colors.white,
                      ),
                      Text(
                        'Locate \nWATM',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  height: 70,
                  minWidth: 70,
                  color: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500)),
                  onPressed: (() async {
                    String qrData = await FlutterBarcodeScanner.scanBarcode(
                        '', 'Cancel', true, ScanMode.QR);
                    String error = Validator.validateQr(qrData);

                    if (error.isNotEmpty) {
                      CustomDialogs.showToast(error);
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => QRScreen(
                                deviceId: extractDeviceId(qrData),
                              ))));
                    }
                  }),
                  child: Column(
                    children: [
                      Icon(
                        Icons.qr_code_scanner_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        'Scan',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  height: 70,
                  minWidth: 100,
                  color: Colors.yellow.shade900,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500)),
                  onPressed: (() {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: ((context) => FAQScreen())));
                  }),
                  child: Column(
                    children: [
                      Icon(
                        Icons.question_answer,
                        color: Colors.white,
                      ),
                      Text(
                        'FAQs',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PrepaidCardScreen()));
                      },
                      child: homeScreenCard(size,
                          'assets/images/prepaid_card.png', 'Prepaid Card',
                          color: Colors.blue.shade100),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PlaceOrderScreen()));
                      },
                      child: homeScreenCard(
                          size, 'assets/images/icons/wow.png', 'Place Order',
                          color: Colors.green.shade100),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DeliveryAddressScreen()));
                      },
                      child: homeScreenCard(
                          size,
                          'assets/images/icons/delivery_icon.png',
                          'My Delivery \nLocations',
                          color: Colors.orange.shade100),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WalletAddMoneyScreen()));
                      },
                      child: homeScreenCard(size,
                          'assets/images/icons/wallet.png', 'Top-Up\nMy Wallet',
                          color: Colors.purple.shade100),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
