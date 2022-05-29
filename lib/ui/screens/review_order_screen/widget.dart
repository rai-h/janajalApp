import 'package:flutter/material.dart';

class PaymentInfo extends StatelessWidget {
  double quantity;
  double amountPerLitre;
  double totalAmount;
  PaymentInfo(
      {Key? key,
      required this.quantity,
      required this.amountPerLitre,
      required this.totalAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantity',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                child: Text(
                  quantity.toString(),
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Per Litre Cost',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                child: Text(
                  amountPerLitre.toString(),
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Cost',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                child: Text(
                  totalAmount.toString(),
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CGST 0%',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                child: Text(
                  "0.00",
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SGST 0%',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                child: Text(
                  "0.00",
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total ',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                child: Text(
                  totalAmount.toString(),
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 18,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScheduledInfo extends StatelessWidget {
  String date;
  String deliveryWindow;
  ScheduledInfo({Key? key, required this.date, required this.deliveryWindow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                child: Text(
                  date,
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deivery Window',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                child: Text(
                  deliveryWindow,
                  style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
