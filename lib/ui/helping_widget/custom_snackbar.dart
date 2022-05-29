import 'package:flutter/material.dart';

showSnackBar({
  required String title,
  required BuildContext context,
  Color? color,
  int milliseconds = 800,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        duration: Duration(seconds: 4),
        padding: EdgeInsets.all(10),
        content: Container(
          height: 70,
          child: Center(
            child: new Text(
              title,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )),
  );
}
