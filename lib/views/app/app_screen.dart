import 'package:flutter/material.dart';

import '../splash/splash_screen.dart';
import '../themes/themes_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemesController.getLightTheme,
      home: const SplashScreen(),
    );
  }
}
