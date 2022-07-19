import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/models/wallet_details_model.dart';
import 'package:janajal/services/wallet_service.dart';
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
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:janajal/utils/validator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String deviceId = '';
  WalletDetailModel? _walletDetailModel;
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
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    await WalletServices.getWalletDetails(context);
    _walletDetailModel =
        Provider.of<AuthController>(context, listen: false).getWalletDetails;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                CustomDialogs.showChangeLanguage(context);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)),
                child: Row(
                  children: [
                    Text(
                      'A',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      '/अ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final InAppReview inAppReview = InAppReview.instance;

                if (await inAppReview.isAvailable()) {
                  // inAppReview.requestReview();
                  inAppReview.openStoreListing();
                }
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow.shade700,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'home_screen.rate_us'.tr(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Share.share(
                    'https://play.google.com/store/apps/details?id=com.jana.janajal',
                    subject: 'Janajal');
                // Share.shareFiles(['assets/images/janajal_khush.png']);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.purple.shade600,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)),
                child: Row(
                  children: [
                    Icon(
                      Icons.share,
                      size: 20,
                      color: Colors.lightGreen,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'home_screen.share_app'.tr(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            )
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
                        'home_screen.locate_watm'.tr(),
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
                        'home_screen.scan'.tr(),
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
                        'home_screen.faqs'.tr(),
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
                      child: homeScreenCard(
                          size,
                          'assets/images/prepaid_card.png',
                          'home_screen.prepaid_card'.tr(),
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
                      child: homeScreenCard(size, 'assets/images/icons/wow.png',
                          'home_screen.place_order'.tr(),
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
                          'home_screen.my_delivery_locations'.tr(),
                          color: Colors.orange.shade100),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print(_walletDetailModel);
                        if (_walletDetailModel != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => WalletAddMoneyScreen()));
                        } else {
                          CustomDialogs.showWalletAlertDialog(context);
                        }
                      },
                      child: homeScreenCard(
                          size,
                          'assets/images/icons/wallet.png',
                          'home_screen.top_up_wallet'.tr(),
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
