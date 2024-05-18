import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/utils/routes/app_routes.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import 'package:spendwise/views/themes/app_images.dart';
import 'package:spendwise/views/widgets/custom_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            AppImages.getStarted,
            height: height * 0.6,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            textAlign: TextAlign.center,
            'Spend Smater \nSave More',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: CustomButton(
              shadows: true,
              height: 67,
              text: 'Get Started',
              onPressed: () {
                context.goNamed(AppRoutes.home);
              },
            ),
          )
        ],
      ),
    );
  }
}
