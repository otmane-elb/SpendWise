import 'package:flutter/material.dart';

import '../../utils/routes/routes_controller.dart';
import '../themes/themes_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemesController.getLightTheme,
    );
  }
}
