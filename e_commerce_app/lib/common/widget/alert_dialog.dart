import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MyAlertDialog {
  static void showDialog(
      {required BuildContext context,
      required String title,
      required String content,
      required VoidCallback pressNo,
      required VoidCallback pressYes}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: pressNo,
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: pressYes,
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
