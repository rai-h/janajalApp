import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:janajal/controller/ui.controller.dart';
import 'package:janajal/models/offer_model.dart';
import 'package:janajal/services/wow_service.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:janajal/utils/shared_pref.dart';
import 'package:provider/provider.dart';

class LanguageOption extends StatefulWidget {
  const LanguageOption({Key? key}) : super(key: key);

  @override
  State<LanguageOption> createState() => _LanguageOptionState();
}

class _LanguageOptionState extends State<LanguageOption> {
  String selecteLanguage = 'English';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getInitialValue() {
    selecteLanguage = context.locale.languageCode == 'hi' ? "Hindi" : "English";
  }

  @override
  void didChangeDependencies() {
    getInitialValue();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                  value: "Hindi",
                  groupValue: selecteLanguage,
                  onChanged: (value) {
                    context.setLocale(Locale('hi', 'IN'));
                    Provider.of<UiController>(context, listen: false)
                        .changeNavbarIndex(0);
                    setState(() {
                      selecteLanguage = value.toString();
                    });
                  }),
              Text('Hindi',
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: "English",
                  groupValue: selecteLanguage,
                  onChanged: (value) {
                    context.setLocale(Locale('en', 'US'));
                    Provider.of<UiController>(context, listen: false)
                        .changeNavbarIndex(0);
                    setState(() {
                      selecteLanguage = value.toString();
                    });
                  }),
              Text(
                'English',
                style: TextStyle(
                    color: Colors.grey.shade800, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
        toastPosition: toastPosition,
        duration: Duration(milliseconds: 1500));
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

  static showOfferListDialog(
      BuildContext context, List<OffersModel> offerModelList) {
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
                    'My Offers',
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
                      SharedPref.saveOfferShownTime(
                          DateTime.now().millisecondsSinceEpoch.toString());
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

  static showChangeLanguage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: LanguageOption(),
          title: Center(
            child: Text(
              'profile_screen.change_language'.tr(),
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
          actions: [
            Center(
              child: MaterialButton(
                color: Colors.green,
                minWidth: 0,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
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
