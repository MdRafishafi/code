import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../helper/message.dart';

class NetworkServiceChecker {
  static NetworkService(
    BuildContext context,
  ) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (e) {
      Message.showRetryTryErrorDialog(
        message: 'Network Error',
        context: context,
      );
    }
  }
}
