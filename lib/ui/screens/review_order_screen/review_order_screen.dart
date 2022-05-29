import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/models/delivery_address_model.dart';
import 'package:janajal/models/user_model.dart';
import 'package:janajal/services/atom_gateway_service.dart';
import 'package:janajal/services/razor_service.dart';
import 'package:janajal/services/wow_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/screens/place_order_screen/widget.dart';
import 'package:janajal/ui/screens/review_order_screen/widget.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ReviewOrderScreen extends StatefulWidget {
  final DeliveryAddressModel deliveryAddressModel;
  final String date;
  final String deliveryWindow;
  final String quntity;

  ReviewOrderScreen(
      {Key? key,
      required this.deliveryAddressModel,
      required this.date,
      required this.deliveryWindow,
      required this.quntity})
      : super(key: key);

  @override
  State<ReviewOrderScreen> createState() => _ReviewOrderScreenState();
}

class _ReviewOrderScreenState extends State<ReviewOrderScreen> {
  double totalAmount = 0.00;
  double amountPerLitre = 1.00;
  UserModel userModel = UserModel();
  Razorpay _razorpay = Razorpay();
  String txnId = DateTime.now().millisecondsSinceEpoch.toString();
  String orderId = '';
  String consignmentNo = '';
  @override
  void initState() {
    userModel =
        Provider.of<AuthController>(context, listen: false).getUserModel!;
    getAmount();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentError);

    // TODO: implement initState
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    callApi();
  }

  callApi() {
    WOWServiece.updateOrderPayment(context,
        amount: totalAmount.toString(),
        consignmentNo: consignmentNo,
        locId: widget.deliveryAddressModel.locId!,
        qty: widget.quntity,
        txnId: txnId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    CustomDialogs.showToast("Payment for Order No: $consignmentNo");
    print(response.message);
  }

  getAmount() async {
    amountPerLitre = double.parse(await WOWServiece.getOrderRate(
        context, widget.deliveryAddressModel.pincode!.toString()));

    totalAmount = amountPerLitre * double.parse(widget.quntity);
    setState(() {});
  }

  String getAddress() {
    return (widget.deliveryAddressModel.area ?? "") +
        ',' +
        (widget.deliveryAddressModel.city ?? "") +
        ',' +
        (widget.deliveryAddressModel.stateName ?? "") +
        '-' +
        (widget.deliveryAddressModel.pincode.toString()) +
        '.' +
        "Landmark:" +
        (widget.deliveryAddressModel.landMark ?? "");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'Review Your Order',
          style: TextStyle(
              fontSize: 24,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        height: size.height - 100,
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/backgroundOne.png',
                ),
                fit: BoxFit.fill)),
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Delivery Address',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.grey.shade700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              AddressBox(deliveryAddressModel: widget.deliveryAddressModel),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Delivery Date & Time',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.grey.shade700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ScheduledInfo(
                deliveryWindow: widget.deliveryWindow,
                date: widget.date,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Order Summary',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.grey.shade700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PaymentInfo(
                amountPerLitre: amountPerLitre,
                totalAmount: totalAmount,
                quantity: double.parse(widget.quntity),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                minWidth: size.width * 0.7,
                elevation: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onPressed: () async {
                  orderId =
                      await RazorPayServices.generateOrder(totalAmount, txnId);

                  if (orderId.isNotEmpty) {
                    consignmentNo = await WOWServiece.saveOrder(
                        context,
                        totalAmount.toString(),
                        widget.deliveryAddressModel.locId!,
                        getAddress(),
                        Janajal.deliveryWindow[widget.deliveryWindow]
                            .toString(),
                        widget.date,
                        widget.deliveryAddressModel.pincode!,
                        widget.quntity,
                        txnId);
                    print(orderId);
                    print(consignmentNo);
                    if (consignmentNo.isNotEmpty) {
                      _razorpay.open(RazorPayServices.createOption(
                          totalAmount,
                          userModel.name ?? "",
                          'Wow Order ${widget.date}',
                          userModel.mobile ?? "",
                          userModel.email ?? "",
                          txnId,
                          orderId));
                    } else {
                      CustomDialogs.showToast("Something went wrong");
                    }
                  } else {
                    CustomDialogs.showToast("Something went wrong");
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                color: Colors.blue.shade900,
                child: const Text(
                  'Proceed to Payment',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
