import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/views/nav_bar/nav_bar.dart';
import 'package:spendwise/views/profile/profile_screen.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import '../../core/providers/homepage/home_provider.dart';
import '../../core/providers/navigation_provider.dart';
import 'widgets/credit_card.dart';
import 'widgets/custom_curved_container.dart';
import 'widgets/transaction_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final homeState = ref.watch(homeStateNotifierProvider);
    final selectedIndex = ref.watch(navigationProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  CustomCurvedContainer(
                    height: height,
                    name: 'Otmane Elbaghazaoui',
                  ),
                  Positioned.fill(
                    bottom: 0,
                    child: CreditCard(
                      height: height,
                      balance: 2548,
                      income: 1840,
                      expense: 284,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Transaction History',
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(
                          'See All',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.greySeeAll),
                        ),
                      ],
                    ),
                    const TransactionWidget(),
                  ],
                ),
              )
            ],
          ),
          const Center(
            child: Text('Another Page'),
          ),
          const ProfileScreen()
        ],
      ),
      bottomNavigationBar: const NavBar(),
      floatingActionButton: Visibility(
        visible: selectedIndex == 0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 50),
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryLightColor,
            shape: const CircleBorder(),
            onPressed: () {
              context.goNamed('addTransaction');
            },
            child: const Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
