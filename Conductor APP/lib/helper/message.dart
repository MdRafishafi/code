import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class Message {
  static void toastMessage({
    @required String message,
    @required BuildContext context,
    Color toastMessageBackgroundColor = const Color(0xc0212121),
  }) {
    return FlutterToast(context).showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: toastMessageBackgroundColor,
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
        gravity: ToastGravity.BOTTOM);
  }

  static void showErrorDialog({
    @required String message,
    @required BuildContext context,
    bool icon = false,
    String title,
  }) {
    showDialog(
      builder: (context) => AlertDialog(
        title: Text(title != null ? title : 'An Error Occurred'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(message),
            icon
                ? Container(
                    height: 150,
                    width: 150,
                    child: Lottie.asset("assets/lottie/error404.json"),
                  )
                : Container(),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Okay'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      context: context,
    );
  }

  static void showRetryTryErrorDialog({
    @required String message,
    @required BuildContext context,
    bool icon = true,
  }) {
    showDialog(
      builder: (context) => AlertDialog(
        title: Text('An Error Occurred'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(message),
            icon
                ? Container(
                    height: 150,
                    width: 150,
                    child: Lottie.asset("assets/lottie/error404.json"),
                  )
                : Container(),
          ],
        ),
      ),
      context: context,
    );
  }

  static showDialogeForMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/earth.json',
                height: 300,
                width: 300,
                alignment: Alignment.center,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50.0,
                      color: Colors.green,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text("Got it",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
