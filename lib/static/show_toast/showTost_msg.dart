import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app_color.dart';

ShowToast({required String msg}) {
  return Fluttertoast.showToast(
      backgroundColor: Colo.black,
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0);
}
