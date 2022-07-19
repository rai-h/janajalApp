import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/services/watm_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:janajal/ui/screens/watm_locator_screen/watm_locator_screen.dart';
import 'package:provider/provider.dart';

class QRScreen extends StatefulWidget {
  final String deviceId;
  const QRScreen({Key? key, required this.deviceId}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  TextEditingController _amountController = TextEditingController();
  String _walletBalace = '0';
  String amountErrorText = '';
  @override
  void initState() {
    _walletBalace = Provider.of<AuthController>(context, listen: false)
            .getWalletDetails!
            .balance ??
        "0";
    print(_walletBalace);
    // TODO: implement initState
    super.initState();
  }

  validate() {
    if (_amountController.text.isEmpty) {
      amountErrorText = 'Please enter the amount';
      setState(() {});
      return false;
    }
    amountErrorText = '';

    if (int.parse(_amountController.text) >
        int.parse(_walletBalace.split('.')[0])) {
      CustomDialogs.showToast('Insufficient Balance');
      setState(() {});
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          'Pay QR',
          style: TextStyle(
              fontSize: 24,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height - 100,
          width: size.width,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/backgroundOne.png',
                  ),
                  fit: BoxFit.fill)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Device Id: ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          widget.deviceId,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Wallet Balance ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '\u{20B9} $_walletBalace',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      errorText: amountErrorText,
                      maxLength: 2,
                      textInputType: TextInputType.number,
                      prefixIcon: Icon(Icons.currency_rupee_rounded),
                      controller: _amountController,
                      text: "my_order_screnn.enter_amount".tr(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      minWidth: 0,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        if (validate()) {
                          WatmServices.saveQRData(
                              context, _amountController.text, widget.deviceId);
                        }
                      },
                      child: const Text(
                        'Proceed To Pay',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
