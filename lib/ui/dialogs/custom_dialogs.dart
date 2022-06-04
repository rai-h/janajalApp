import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:janajal/controller/ui.controller.dart';
import 'package:janajal/services/wow_service.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:provider/provider.dart';

class CustomDialogs {
  static showLoading() {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }

  static dismissLoading() {
    EasyLoading.dismiss();
  }

  static showToast(String title,
      {EasyLoadingToastPosition toastPosition =
          EasyLoadingToastPosition.center}) {
    EasyLoading.showToast(title,
        dismissOnTap: false, toastPosition: toastPosition);
  }

  static showWalletAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              child: Text(
            'Please verify your mobile number to activate you wallet.',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          )),
          title: Center(
            child: Text(
              'Verify Your Mobile',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
          actions: [
            MaterialButton(
              color: Colors.green,
              minWidth: 0,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<UiController>(context, listen: false)
                    .changeNavbarIndex(3);
              },
              child: const Text(
                'Verify',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              minWidth: 0,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  static showRatingDialog(
    BuildContext context,
    String orderId,
    String rating,
    String remarks,
  ) {
    TextEditingController controller = TextEditingController();
    int selectedRating = 0;

    controller.text = remarks;
    selectedRating = int.parse(rating);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 220,
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState((() {
                                selectedRating = 1;
                              }));
                            },
                            child: Icon(
                              Icons.sentiment_very_dissatisfied,
                              size: 40,
                              color: selectedRating == 1
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState((() {
                                selectedRating = 2;
                              }));
                            },
                            child: Icon(
                              Icons.sentiment_dissatisfied,
                              size: 40,
                              color: selectedRating == 2
                                  ? Colors.redAccent
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState((() {
                                selectedRating = 3;
                              }));
                            },
                            child: Icon(
                              Icons.sentiment_neutral,
                              size: 40,
                              color: selectedRating == 3
                                  ? Colors.amber
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState((() {
                                selectedRating = 4;
                              }));
                            },
                            child: Icon(
                              Icons.sentiment_satisfied,
                              size: 40,
                              color: selectedRating == 4
                                  ? Colors.lightGreen
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState((() {
                                selectedRating = 5;
                              }));
                            },
                            child: Icon(
                              Icons.sentiment_very_satisfied,
                              size: 40,
                              color: selectedRating == 5
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                      // RatingBar.builder(
                      //   initialRating: 2,
                      //   itemCount: 5,
                      //   itemBuilder: (context, index) {
                      //     switch (index) {
                      //       case 0:
                      //         return Icon(
                      //           Icons.sentiment_very_dissatisfied,
                      //           color: Colors.red,
                      //         );
                      //       case 1:
                      //         return Icon(
                      //           Icons.sentiment_dissatisfied,
                      //           color: Colors.redAccent,
                      //         );
                      //       case 2:
                      //         return Icon(
                      //           Icons.sentiment_neutral,
                      //           color: Colors.amber,
                      //         );
                      //       case 3:
                      //         return Icon(
                      //           Icons.sentiment_satisfied,
                      //           color: Colors.lightGreen,
                      //         );

                      //       case 4:
                      //         return Icon(
                      //           Icons.sentiment_very_satisfied,
                      //           color: Colors.green,
                      //         );
                      //       default:
                      //         return Container();
                      //     }
                      //   },
                      //   onRatingUpdate: (rating) {
                      //     print(rating);
                      //   },
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        enabled: rating == '0',
                        text: "Comments",
                        maxLines: 3,
                        controller: controller,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      rating != '0'
                          ? Container()
                          : MaterialButton(
                              color: Colors.blue,
                              minWidth: 0,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () async {
                                await WOWServiece.saveOrderRating(
                                    context,
                                    orderId,
                                    selectedRating.toString(),
                                    controller.text,
                                    '2');
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
          title: Center(
            child: Text(
              'Rate Your Order',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
