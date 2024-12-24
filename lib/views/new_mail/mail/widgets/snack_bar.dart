import 'package:flutter/material.dart';

SnackBar buildSnackBar(BuildContext context, String msg) {
  return SnackBar(
    content: Text(
      msg,
      style: TextStyle(
        fontSize: 16,
      ),
    ),
    backgroundColor: Colors.redAccent,
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Dismiss',
      disabledTextColor: Colors.white,
      textColor: Colors.yellow,
      onPressed: () async {
        //Do whatever you want
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
}
