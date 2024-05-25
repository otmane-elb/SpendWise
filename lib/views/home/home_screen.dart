import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/views/history/history_screen.dart';
import 'package:spendwise/views/nav_bar/nav_bar.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import '../../core/models/transaction_model/transaction_model.dart';
import '../../core/providers/financial_data_provider.dart';
import '../../core/providers/navigation_provider.dart';
import '../../core/providers/transaction_provider.dart';
import 'widgets/credit_card.dart';
import 'widgets/custom_curved_container.dart';
import 'widgets/transactions_history.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final selectedIndex = ref.watch(navigationProvider);
    final transactions = ref.watch(transactionProvider);
    final financialData = ref.watch(financialDataProvider);

    ref.listen<List<Transaction>>(transactionProvider, (previous, next) {
      ref.read(financialDataProvider.notifier).updateTransactions(next);
    });

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
                    name: 'Dear User',
                  ),
                  Positioned.fill(
                    child: CreditCard(
                      height: height,
                      balance: financialData.balance,
                      income: financialData.income,
                      expense: financialData.expense,
                    ),
                  ),
                ],
              ),
              TransactionHistory(
                transactions: transactions,
                onDismissed: (transaction) {
                  ref
                      .read(transactionProvider.notifier)
                      .removeTransaction(transaction);
                },
              ),
            ],
          ),
          HistoryScreen(
            transactions: transactions,
            onDismissed: (transaction) {
              ref
                  .read(transactionProvider.notifier)
                  .removeTransaction(transaction);
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryLightColor,
          shape: const CircleBorder(),
          onPressed: () {
            context.pushNamed('addTransaction');
          },
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
