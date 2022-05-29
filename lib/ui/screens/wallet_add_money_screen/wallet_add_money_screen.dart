import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/models/user_model.dart';
import 'package:janajal/models/wallet_details_model.dart';
import 'package:janajal/services/razor_service.dart';
import 'package:janajal/services/wallet_service.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletAddMoneyScreen extends StatefulWidget {
  const WalletAddMoneyScreen({Key? key}) : super(key: key);

  @override
  State<WalletAddMoneyScreen> createState() => _WalletAddMoneyScreenState();
}

class _WalletAddMoneyScreenState extends State<WalletAddMoneyScreen> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _promoCodeController = TextEditingController();

  String amountErrorText = '';

  Razorpay _razorpay = Razorpay();
  String txnId = DateTime.now().millisecondsSinceEpoch.toString();

  WalletDetailModel walletDetailModel = WalletDetailModel();

  UserModel _userModel = UserModel();
  @override
  void initState() {
    walletDetailModel =
        Provider.of<AuthController>(context, listen: false).getWalletDetails!;
    _userModel =
        Provider.of<AuthController>(context, listen: false).getUserModel!;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentError);

    // TODO: implement initState
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    WalletServices.updateWalletRechargeBody(
        context, _amountController.text, _amountController.text, '', txnId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
  }

  void callRazorPay() async {
    String orderId = await RazorPayServices.generateOrder(
        double.parse(_amountController.text), txnId);

    _razorpay.open(RazorPayServices.createOption(
        double.parse(_amountController.text),
        _userModel.name ?? "",
        "Wallet Recharge",
        _userModel.mobile ?? "",
        _userModel.email ?? "",
        txnId,
        orderId));
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
          'Add Money',
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
                          'Wallet No.: ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          walletDetailModel.walletNo ?? "",
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
                          'Balance ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '\u{20B9} ${walletDetailModel.balance}',
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
                      prefixIcon: Icon(Icons.currency_rupee_rounded),
                      controller: _amountController,
                      text: 'Enter Amount',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          color: Colors.green,
                          minWidth: 0,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            setState(() {
                              _amountController.text = '100';
                            });
                          },
                          child: const Text(
                            '+ 100',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.green,
                          minWidth: 0,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            setState(() {
                              _amountController.text = '200';
                            });
                          },
                          child: const Text(
                            '+ 200',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.green,
                          minWidth: 0,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            setState(() {
                              _amountController.text = '500';
                            });
                          },
                          child: const Text(
                            '+ 500',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.green,
                          minWidth: 0,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            setState(() {
                              _amountController.text = '1000';
                            });
                          },
                          child: const Text(
                            '+ 1000',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
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
                      onPressed: () async {
                        if (_amountController.text.isNotEmpty) {
                          amountErrorText = '';
                          setState(() {});
                          print(txnId);
                          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

                          if (await WalletServices.saveWalletRecharge(
                              context,
                              _amountController.text,
                              _amountController.text,
                              '',
                              txnId)) {
                            callRazorPay();
                          }
                        } else {
                          amountErrorText = 'Please enter amount';
                          setState(() {});
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
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Text(
                        'Apply Promo',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w700),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Enter Promo Code(Optional)',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      text: 'Enter Promo Code',
                      controller: _promoCodeController,
                    ),
                    const SizedBox(
                      height: 10,
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
                      onPressed: () {},
                      child: const Text(
                        'Apply',
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
