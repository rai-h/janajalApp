import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/services/prepaid_card_service.dart';
import 'package:janajal/services/wallet_service.dart';
import 'package:janajal/ui/screens/log_screen/widget.dart';
import 'package:janajal/ui/screens/watm_locator_screen/watm_locator_screen.dart';
import 'package:provider/provider.dart';

class LogScreen extends StatefulWidget {
  final bool isWallet;
  final bool isTopUp;
  final String cardNo;
  const LogScreen(
      {Key? key,
      required this.isTopUp,
      required this.isWallet,
      this.cardNo = ''})
      : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List dataList = [];
  String walletNo = '';
  String heading = '';

  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    walletNo = Provider.of<AuthController>(context, listen: false)
            .getWalletDetails!
            .walletNo ??
        '';
    print(widget.isTopUp);
    print(widget.isWallet);
    heading = widget.isTopUp ? 'wallet_screen.top_log'.tr() : 'wallet_screen.txn_log'.tr();
    dataList = widget.isWallet
        ? widget.isTopUp
            ? await WalletServices.getWalletTopUpList(context)
            : await WalletServices.getWalletTxnList(context)
        : widget.isTopUp
            ? await PrepaidCardServices.getPrepaicardTopUpList(
                context, widget.cardNo)
            : await PrepaidCardServices.getPrepaicardTxnList(
                context, widget.cardNo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
          heading,
          style: TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: dataList.isEmpty
          ? Center(
              child: Text(
                'No Data Available',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: widget.isWallet
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'wallet_screen.wallet_no'.tr()+" : ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              walletNo,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: size.height * 0.78,
                          child: widget.isTopUp
                              ? ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: dataList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: WalletTopUpCard(
                                          dateTime: dataList[index]
                                              ['createdOn'],
                                          paidAmount: dataList[index]['paid'],
                                          rechargeAmount: dataList[index]
                                              ['value']),
                                    );
                                  })
                              : ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: dataList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: WalletTxnCard(
                                        amount: dataList[index]['value'],
                                        date: dataList[index]['createdOn'],
                                        location: dataList[index]['watmCode'],
                                        quantity: dataList[index]['sku'],
                                        status: dataList[index]['txnType'],
                                        refundTime: dataList[index]
                                            ['refundTime'],
                                      ),
                                    );
                                  }),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Card No : ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.cardNo,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        widget.isTopUp
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: dataList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: WalletTopUpCard(
                                        dateTime: dataList[index]['createdOn'],
                                        paidAmount: dataList[index]['paid'],
                                        rechargeAmount: dataList[index]
                                            ['value']),
                                  );
                                })
                            : Container()
                      ],
                    ),
            ),
    );
  }
}
