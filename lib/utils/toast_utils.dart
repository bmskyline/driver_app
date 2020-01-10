import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;

class Toast {
  static void show(String message) {
    toast.Fluttertoast.showToast(
        msg: message,
        toastLength: toast.Toast.LENGTH_SHORT,
        gravity: toast.ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
