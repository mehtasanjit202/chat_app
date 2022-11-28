import 'package:flutter/material.dart';

import '../main.dart';

showSuccessSnacks(String message) {
  ScaffoldMessenger.of(AppSetting.navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: Colors.green,
    ),
  );
}

showErrorSnacks(String message) {
  ScaffoldMessenger.of(AppSetting.navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: Colors.red,
    ),
  );
}
