import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/views/home/widgets/curved_container.dart';
import 'package:spendwise/views/themes/app_colors.dart';

class CustomCurvedContainer extends StatelessWidget {
  const CustomCurvedContainer({
    super.key,
    required this.height,
    this.greetings = 'Good morning',
    this.name = 'User',
    this.isHome = true,
    this.pageName = 'page',
    this.isPop = false,
  });

  final double height;
  final String? greetings;
  final String name;
  final String pageName;
  final bool isHome;
  final bool isPop;

  @override
  Widget build(BuildContext context) {
    return CurvedContainer(
      height: height / 2.9,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 16.0, vertical: height * 0.055),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isHome
                ? Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$greetings,',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(name,
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: isPop,
                        child: IconButton(
                          onPressed: () {
                            if (context.canPop()) context.replaceNamed('home');
                            ;
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Text(pageName,
                          style: Theme.of(context).textTheme.bodyLarge),
                      const Icon(
                        Icons.more_horiz,
                        color: AppColors.white,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
