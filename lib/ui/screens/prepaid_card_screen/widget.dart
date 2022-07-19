import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:janajal/services/prepaid_card_service.dart';
import 'package:janajal/ui/screens/log_screen/log_screen.dart';
import 'package:janajal/ui/screens/prepaid_card_recharge_screen/prepaid_card_recharge_screen.dart';
import 'package:janajal/utils/janajal.dart';

class PrepaidCard extends StatefulWidget {
  final String cardNo;
  final String balance;
  const PrepaidCard({Key? key, required this.cardNo, required this.balance})
      : super(key: key);

  @override
  State<PrepaidCard> createState() => _PrepaidCardState();
}

class _PrepaidCardState extends State<PrepaidCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: size.width * 0.9,
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Container(
            child: Center(
              child: Text(
                'prepaid_card_screen.janajal_prepaid_card'.tr(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
            height: 35,
            width: size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.shade900),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'prepaid_card_screen.card_no'.tr() + " : ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                widget.cardNo,
                style: TextStyle(
                    fontSize: 18,
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
                'prepaid_card_screen.balance'.tr() + " : ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                '\u{20B9} ${widget.balance}',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                elevation: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LogScreen(
                            isTopUp: false,
                            isWallet: false,
                            cardNo: widget.cardNo,
                          )));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                color: Janajal.secondaryColor,
                child: Text(
                  'prepaid_card_screen.txn_log'.tr(),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              MaterialButton(
                elevation: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LogScreen(
                            isTopUp: true,
                            isWallet: false,
                            cardNo: widget.cardNo,
                          )));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                color: Colors.green.shade800,
                child: Text(
                  'prepaid_card_screen.top_log'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          MaterialButton(
            minWidth: size.width * 0.7,
            elevation: 10,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => PrepaidCardRechargeScreen(
                        cardNo: widget.cardNo,
                        balance: widget.balance,
                      ))));
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            color: Colors.orange.shade900,
            child: Text(
              'prepaid_card_screen.recharge'.tr(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
