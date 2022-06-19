import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/controller/ui.controller.dart';
import 'package:janajal/models/wallet_details_model.dart';
import 'package:janajal/services/wallet_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/helping_widget/round_button.dart';
import 'package:janajal/ui/screens/log_screen/log_screen.dart';
import 'package:janajal/ui/screens/wallet_add_money_screen/wallet_add_money_screen.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  WalletDetailModel? _walletDetailModel;
  bool isLoading = false;
  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    isLoading = true;
    await WalletServices.getWalletDetails(context);
    _walletDetailModel =
        Provider.of<AuthController>(context, listen: false).getWalletDetails;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title:  Text(
          'navbar.my_wallet'.tr(),
          style: TextStyle(
              fontSize: 30,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: isLoading
            ? Container()
            : _walletDetailModel == null
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
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
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
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: size.width,
                    child: Column(
                      children: [
                        Material(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: size.width * 0.9,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _walletDetailModel!.walletNo!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'wallet_screen.wallet_balance'.tr(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Icon(
                                      Icons.account_balance_wallet_rounded,
                                      size: 50,
                                      color: Janajal.primaryColor,
                                    ),
                                  ],
                                ),
                                Text(
                                  '\u{20B9} ${_walletDetailModel!.balance!}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    MaterialButton(
                                      elevation: 10,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => LogScreen(
                                                    isTopUp: false,
                                                    isWallet: true)));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      color: Janajal.secondaryColor,
                                      child:  Text(
                                        'wallet_screen.txn_log'.tr(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    MaterialButton(
                                      elevation: 10,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => LogScreen(
                                                    isTopUp: true,
                                                    isWallet: true)));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      color: Colors.green.shade800,
                                      child:  Text(
                                         'wallet_screen.top_log'.tr(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: size.width * 0.9,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'wallet_screen.promo_balance'.tr(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Image.asset(
                                      'assets/images/offer.png',
                                      height: 60,
                                    )
                                  ],
                                ),
                                Text(
                                  '\u{20B9} ${_walletDetailModel!.promoBal!}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'wallet_screen.expiry'.tr()+" : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      '${_walletDetailModel!.expiryDate!}',
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
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          elevation: 10,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WalletAddMoneyScreen()));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          color: Colors.orange.shade900,
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.8,
                            child:  Text(
                              'wallet_screen.add_money'.tr(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
