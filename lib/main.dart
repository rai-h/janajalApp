import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajal/base_app/base_app.dart';
import 'package:janajal/controller/auth.controller.dart';
import 'package:janajal/controller/order.controller.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'controller/ui.controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
