import 'package:flutter/material.dart';
import 'views/app/app_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('isFirst');
  runApp(
    const MyApp(),
  );
}
