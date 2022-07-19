import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class WalletTxnCard extends StatefulWidget {
  final String date;
  final String amount;
  final String quantity;
  final String status;
  final String location;
  final String refundTime;
  final String tnxId;

  const WalletTxnCard(
      {Key? key,
      required this.amount,
      required this.date,
      required this.quantity,
      required this.status,
      required this.location,
      required this.tnxId,
      required this.refundTime})
      : super(key: key);

  @override
  State<WalletTxnCard> createState() => _WalletTxnCardState();
}

class _WalletTxnCardState extends State<WalletTxnCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'wallet_screen.paid_amount'.tr() + " : ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '\u{20B9} ${widget.amount}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    widget.quantity == '-'
                        ? Container()
                        : Row(
                            children: [
                              Text(
                                'wallet_screen.quantity'.tr() + " : ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                widget.quantity,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'wallet_screen.location'.tr() + " : ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.location,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                widget.tnxId.isEmpty
                    ? Container()
                    : Row(
                        children: [
                          Text(
                            'wallet_screen.transaction_id'.tr() + " : ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.tnxId,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'wallet_screen.status'.tr() + " : ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.status == '5'
                          ? 'Failed'
                          : widget.status == '9'
                              ? 'Pending'
                              : 'Success',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                widget.status == '5'
                    ? Row(
                        children: [
                          Text(
                            'Refund Date' + " : ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.refundTime,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
            widget.quantity == '-'
                ? Column(
                    children: [
                      Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/water_drop.png'))),
                      ),
                      Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/jjwowlogo.png'))),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class WalletTopUpCard extends StatefulWidget {
  final String dateTime;
  final String paidAmount;
  final String rechargeAmount;
  const WalletTopUpCard(
      {Key? key,
      required this.dateTime,
      required this.paidAmount,
      required this.rechargeAmount})
      : super(key: key);

  @override
  State<WalletTopUpCard> createState() => _WalletTopUpCardState();
}

class _WalletTopUpCardState extends State<WalletTopUpCard> {
  String totalAmount = '';
  @override
  void initState() {
    totalAmount =
        (double.parse(widget.rechargeAmount) - double.parse(widget.paidAmount))
            .toString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.dateTime.substring(0, 10),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'wallet_screen.paid_amount'.tr() + " : ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\u{20B9} ${totalAmount}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'wallet_screen.amount'.tr() + " : ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\u{20B9} ${widget.rechargeAmount}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  color: Colors.blue.shade900,
                  size: 16,
                ),
                Text(
                  widget.dateTime.substring(10),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrePaidCardTxnCard extends StatefulWidget {
  final String dateTime;
  final String amount;
  final String sku;
  const PrePaidCardTxnCard(
      {Key? key,
      required this.dateTime,
      required this.amount,
      required this.sku})
      : super(key: key);

  @override
  State<PrePaidCardTxnCard> createState() => _PrePaidCardTxnCardState();
}

class _PrePaidCardTxnCardState extends State<PrePaidCardTxnCard> {
  String totalAmount = '';
  @override
  void initState() {
    totalAmount = widget.amount;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.dateTime.substring(0, 10),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'SKU' + " : ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\u{20B9} ${totalAmount}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'wallet_screen.amount'.tr() + " : ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\u{20B9} ${widget.amount}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  color: Colors.blue.shade900,
                  size: 16,
                ),
                Text(
                  widget.dateTime.substring(10),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
