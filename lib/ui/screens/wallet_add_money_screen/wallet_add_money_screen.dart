import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/controller/ui.controller.dart';
import 'package:janajal/models/offer_model.dart';
import 'package:janajal/models/user_model.dart';
import 'package:janajal/models/wallet_details_model.dart';
import 'package:janajal/services/razor_service.dart';
import 'package:janajal/services/wallet_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:janajal/ui/helping_widget/round_button.dart';
import 'package:janajal/utils/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletAddMoneyScreen extends StatefulWidget {
  const WalletAddMoneyScreen({Key? key}) : super(key: key);

  @override
  State<WalletAddMoneyScreen> createState() => _WalletAddMoneyScreenState();
}

class _WalletAddMoneyScreenState extends State<WalletAddMoneyScreen> {
  TextEditingController _amountController = TextEditingController();

  String amountErrorText = '';

  Razorpay _razorpay = Razorpay();
  String txnId = DateTime.now().millisecondsSinceEpoch.toString();

  WalletDetailModel? walletDetailModel;
  List<OffersModel> _offerModelList = [];

  UserModel _userModel = UserModel();

  bool showPromo = false;
  bool promoAplied = false;
  OffersModel? _appliedPromo;
  String discountAmount = '0';

  String promoErrorText = '';
  @override
  void initState() {
    walletDetailModel =
        Provider.of<AuthController>(context, listen: false).getWalletDetails;
    _offerModelList =
        Provider.of<AuthController>(context, listen: false).getOfferModelList;
    _userModel =
        Provider.of<AuthController>(context, listen: false).getUserModel!;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentError);

    // TODO: implement initState
    super.initState();
  }

  showOfferListDialog(BuildContext context, List<OffersModel> offerModelList) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          width: size.width * 0.9,
          height: size.height * 0.4,
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(10),
              height: 500,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/backgroundOne.png',
                      ),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white),
              child: Column(
                children: [
                  Text(
                    'wallet_screen.my_offer'.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey.withOpacity(0.2),
                    ),
                    height: 360,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: offerModelList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                  'Promo Code : ${offerModelList[index].promoCode}'),
                              subtitle: Text(
                                  'Get ${offerModelList[index].discount} % extra on rechanrge of amount ${offerModelList[index].amount}.'),
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.blue.shade800,
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await applyPromo(
                                    offerModelList[index].promoCode ?? "");
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                'wallet_screen.apply'.tr(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.red.shade400,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> applyPromo(String promoCode) async {
    _offerModelList.forEach((element) {
      if (element.promoCode! == promoCode) {
        _appliedPromo = element;
      }
    });

    if (_appliedPromo != null) {
      if (await WalletServices.checkPromo(context, _appliedPromo!.discount!,
          _appliedPromo!.amount!, _appliedPromo!.promoCode!)) {
        discountAmount = (double.parse(_appliedPromo!.amount!) *
                (double.parse(_appliedPromo!.discount!) / 100))
            .toString();
        // String amount = (double.parse(_appliedPromo!.amount!) +
        //         (double.parse(discountAmount)))
        // .toString();
        _amountController.text = _appliedPromo!.amount!;
        promoAplied = true;
        setState(() {});
      }
    }
  }

  Future<void> removePromo() async {
    _amountController.text = _appliedPromo!.amount!;
    promoAplied = false;
    _appliedPromo = null;
    discountAmount = '0';
    setState(() {});
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await WalletServices.updateWalletRechargeBody(
        context,
        _amountController.text,
        discountAmount,
        _appliedPromo == null ? "" : _appliedPromo!.promoCode!,
        txnId);
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
        title: Text(
          'wallet_screen.add_money'.tr(),
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
          child: walletDetailModel == null
              ? AlertDialog(
                  content: Container(
                      child: Text(
                    'Please verify your mobile number to activate you wallet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  )),
                  actions: [
                    Center(
                      child: MaterialButton(
                        color: Colors.blue,
                        minWidth: 0,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Provider.of<UiController>(context, listen: false)
                              .changeNavbarIndex(3);
                        },
                        child: const Text(
                          'Verify',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
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
                                'wallet_screen.wallet_no'.tr() + " : ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                walletDetailModel!.walletNo ?? "",
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
                                'wallet_screen.balance'.tr() + " : ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                '\u{20B9} ${walletDetailModel!.balance}',
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
                            enabled: !promoAplied,
                            prefixIcon: Icon(Icons.currency_rupee_rounded),
                            controller: _amountController,
                            text: "my_order_screnn.enter_amount".tr(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MaterialButton(
                                color: promoAplied
                                    ? Colors.green.shade200
                                    : Colors.green,
                                minWidth: 0,
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: promoAplied
                                    ? () {}
                                    : () {
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
                                color: promoAplied
                                    ? Colors.green.shade200
                                    : Colors.green,
                                minWidth: 0,
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: promoAplied
                                    ? () {}
                                    : () {
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
                                color: promoAplied
                                    ? Colors.green.shade200
                                    : Colors.green,
                                minWidth: 0,
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: promoAplied
                                    ? () {}
                                    : () {
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
                                color: promoAplied
                                    ? Colors.green.shade200
                                    : Colors.green,
                                minWidth: 0,
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: promoAplied
                                    ? () {}
                                    : () {
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
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showPromo = showPromo ? false : true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              'wallet_screen.apply_promo'.tr(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700),
                            ),
                            Icon(
                              showPromo
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                    ),
                    showPromo
                        ? Container(
                            width: size.width * 0.9,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Column(
                              children: [
                                promoAplied
                                    ? Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blueGrey.shade100
                                                .withOpacity(0.4)),
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          child: ListTile(
                                            leading: Text(
                                              '${_appliedPromo!.discount!} %',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            title: Text(
                                              '${_appliedPromo!.promoCode!}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            subtitle: Text(
                                              "Get ${_appliedPromo!.discount} % extra on rechanrge of amount ${_appliedPromo!.amount}.",
                                            ),
                                            trailing: GestureDetector(
                                                onTap: () {
                                                  removePromo();
                                                },
                                                child: Icon(Icons.close)),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 10,
                                ),
                                MaterialButton(
                                  color: Colors.purple.shade500,
                                  minWidth: 0,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    showOfferListDialog(
                                        context, _offerModelList);
                                  },
                                  child: Text(
                                    'wallet_screen.get_offers'.tr(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
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
                          if (await WalletServices.saveWalletRecharge(
                              context,
                              _amountController.text,
                              discountAmount,
                              _appliedPromo == null
                                  ? ""
                                  : _appliedPromo!.promoCode!,
                              txnId)) {
                            callRazorPay();
                          }
                        } else {
                          amountErrorText = 'Please enter amount';
                          setState(() {});
                        }
                      },
                      child: Text(
                        'wallet_screen.proceed_to_pay'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
