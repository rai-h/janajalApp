import 'package:flutter/material.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // leading: GestureDetector(
        //     onTap: () {
        //       Future.delayed(Duration(milliseconds: 100), () {
        //         Navigator.of(context).pop();
        //       });
        //     },
        //     child: Icon(Icons.arrow_back_ios_new_sharp)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'About Us',
          style: TextStyle(
              fontSize: 20,
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'SUPREMUS DEVELOPERS (P) LTD.',
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: Janajal.aboutDesc,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 15,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    if (!await launchUrl(Uri.parse('https://www.janajal.com')))
                      throw 'Could not launch';
                  },
                  child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: 'https://www.janajal.com',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Certification',
                  style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text(
                          'ISO 14001:2015',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'ISO 9001:2015',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'ISO 45001:2018',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'ISO /IEC 27001:2013',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(Uri.parse(
                            'https://www.facebook.com/JanaJalImpact')))
                          throw 'Could not launch';
                      },
                      child: Material(
                        elevation: 10,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.facebook_rounded,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(Uri.parse(
                            'https://www.youtube.com/channel/UCbgNqJ3uaFdbiXbtWWY8OOw/videos')))
                          throw 'Could not launch';
                      },
                      child: Material(
                        elevation: 10,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/icons/youtube_icon.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(Uri.parse(
                            'https://www.instagram.com/janajalimpact')))
                          throw 'Could not launch';
                      },
                      child: Material(
                        elevation: 10,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/icons/insta_icon.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(
                            Uri.parse('https://twitter.com/janajalimpact')))
                          throw 'Could not launch';
                      },
                      child: Material(
                        elevation: 10,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/icons/twitter_icon.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(Uri.parse(
                            'https://www.linkedin.com/company/janajal')))
                          throw 'Could not launch';
                      },
                      child: Material(
                        elevation: 10,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/icons/linkedIn_icon.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
