import 'package:flutter/material.dart';
import 'package:janajal/ui/helping_widget/round_button.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:launch_review/launch_review.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Material(
              elevation: 10,
              color: Colors.blue.shade300,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width,
                  child: Text(
                    'We have added some new features for you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            SizedBox(
                width: size.width * 0.7,
                child: Image.asset('assets/images/jjwowlogo.png')),
            SizedBox(
              height: size.height * 0.15,
            ),
            RoundButton(
                onPress: () {
                  LaunchReview.launch(
                    writeReview: false,
                    androidAppId: "com.jana.janajal",
                  );
                },
                color: Janajal.primaryColor,
                text: 'Update Now'),
            Spacer()
          ],
        ),
      ),
    );
  }
}
