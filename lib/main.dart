import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajal/base_app/base_app.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/controller/order.controller.dart';
import 'package:janajal/ui/screens/main_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';

import 'controller/ui.controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //   apiKey: "AIzaSyBmOJdWlf3BRzRmbWP1PmYwXNxcTrzI1o4",
      //   appId: "com.jana.janajal",
      //   messagingSenderId: "1025055880246",
      //   projectId: "varsha-c1dbf",
      // ),
      );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UiController(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
  configLoading();
  if (kIsWeb) {
  } else {
    // NOT running on the web! You can check for additional platforms here.
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Janajal',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: BaseApp(),
      builder: EasyLoading.init(),
    );
  }
}
