import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotifyVm with ChangeNotifier {
  bool isShowing = false;
  String msg = '';
  showMsg(String msg, [int? duration]) async {
    this.msg = msg;
    isShowing = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: duration ?? 2));
    isShowing = false;
    notifyListeners();
  }

  showSnackbar(Text msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: msg,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
    ));
  }
}

final notifyVm = ChangeNotifierProvider<NotifyVm>((ref) {
  return NotifyVm();
});
