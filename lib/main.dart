import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/models/transaction_model/transaction_model.dart';
import 'views/app/app_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox('isFirst');
  runApp(
    const MyApp(),
  );
}
