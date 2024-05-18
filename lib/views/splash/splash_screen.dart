import 'package:flutter/material.dart';

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
    /* final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstInstall = prefs.getBool("first_install");
    if (isFirstInstall != false) {
      Get.offAndToNamed(AppRoutes.onboarding);
      await prefs.setBool("first_install", false);
    } else {
      Get.offAndToNamed(AppRoutes.navScreen);
    }
    */
  }
}
