import 'package:flutter/material.dart';
import 'package:osolutions_app/core/localization/app_localization.dart';
import 'package:osolutions_app/core/utils/app_routes.dart';

void showSnackbar(String message, {bool error = false}) {
  if (message.contains('Unauthenticated')) return;
  closeSnackbar();
  final isAr = getLocale.languageCode == 'ar';
  ScaffoldMessenger.of(AppNavigator.context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      ),
      backgroundColor: error ? Colors.red : Colors.green,
    ),
  );
}

void closeSnackbar() {
  ScaffoldMessenger.of(AppNavigator.context).clearSnackBars();
}
