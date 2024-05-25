import 'dart:developer';

import 'package:flutter/services.dart';

class WidgetUpdater {
  static const platform = MethodChannel('com.otmane.spendwise/widget');

  static Future<void> updateWidget(
      double balance, double income, double expense) async {
    try {
      await platform.invokeMethod('updateWidget', {
        'balance': balance,
        'income': income,
        'expense': expense,
      });
    } on PlatformException catch (e) {
      log("Failed to update widget: '${e.message}'.");
    }
  }
}
