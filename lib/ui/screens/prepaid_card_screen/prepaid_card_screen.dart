import 'package:flutter/material.dart';
import 'package:janajal/services/prepaid_card_service.dart';
import 'package:janajal/ui/screens/prepaid_card_screen/widget.dart';
import 'package:janajal/utils/janajal.dart';

class PrepaidCardScreen extends StatefulWidget {
  const PrepaidCardScreen({Key? key}) : super(key: key);

  @override
  State<PrepaidCardScreen> createState() => _PrepaidCardScreenState();
}

class _PrepaidCardScreenState extends State<PrepaidCardScreen> {
  List<dynamic> ppCardList = [];

  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    ppCardList = await PrepaidCardServices.getPrepaidCardList(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
          'Prepaid Card',
          style: TextStyle(
              fontSize: 24,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/backgroundOne.png',
                ),
                fit: BoxFit.fill)),
        width: size.width,
        child: ListView.builder(
            itemCount: ppCardList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: PrepaidCard(
                  cardNo: ppCardList[index]['cardNo'],
                  balance: ppCardList[index]['balance'],
                ),
              );
            }),
      ),
    );
  }
}
