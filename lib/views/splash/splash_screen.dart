import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/routes/app_routes.dart';
import '../themes/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween<double>(begin: 0.1, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.elasticOut),
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          toNextScreen();
        }
      });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Center(
            child: ScaleTransition(
              scale: animation,
              child: Text(
                'SpendWise',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: .9,
                  colors: [
                    AppColors.primaryColor.withOpacity(.4),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomRight,
                  radius: .9,
                  colors: [
                    AppColors.primaryColor.withOpacity(.4),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  toNextScreen() async {
    var box = Hive.box('isFirst');
    bool? isFirstTime = box.get('isFirstTime', defaultValue: true);
    if (isFirstTime != false) {
      context.replaceNamed(AppRoutes.getStarted);
      await box.put('isFirstTime', false);
    } else {
      context.replaceNamed(AppRoutes.home);
    }
  }
}
