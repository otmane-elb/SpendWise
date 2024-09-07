import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/views/history/history_screen.dart';
import 'package:spendwise/views/home/widgets/transactions_history.dart';
import 'package:spendwise/views/nav_bar/nav_bar.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import '../../core/models/transaction_model/transaction_model.dart';
import '../../core/providers/financial_data_provider.dart';
import '../../core/providers/navigation_provider.dart';
import '../../core/providers/transaction_provider.dart';
import 'widgets/credit_card.dart';
import 'widgets/custom_curved_container.dart';

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

    // Calculate total balance, income, and expense across all months
    double totalBalance = 0;
    double totalIncome = 0;
    double totalExpense = 0;

    financialData.forEach((month, data) {
      totalBalance += data.balance;
      totalIncome += data.income;
      totalExpense += data.expense;
    });

    // Initialize PageController with the initial page set to the last page
    final PageController pageController =
        PageController(initialPage: financialData.length);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: CustomCurvedContainer(
          height: height,
          name: 'Dear User',
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          Column(
            children: [
              if (financialData.isNotEmpty)
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: pageController, // Set the controller
                    itemCount:
                        financialData.length + 1, // +1 for the summary card
                    itemBuilder: (context, index) {
                      if (index < financialData.length) {
                        // Regular month cards
                        final monthKey = financialData.keys.elementAt(index);
                        final monthData = financialData[monthKey]!;
                        return CreditCard(
                          balance: monthData.balance,
                          income: monthData.income,
                          expense: monthData.expense,
                          month: monthKey,
                        );
                      } else {
                        // Summary card for all months
                        return CreditCard(
                          balance: totalBalance,
                          income: totalIncome,
                          expense: totalExpense,
                          month: 'Total', // Label for the summary card
                        );
                      }
                    },
                  ),
                ),
              Expanded(
                child: TransactionHistory(
                  transactions: transactions,
                  onDismissed: (transaction) {
                    ref
                        .read(transactionProvider.notifier)
                        .removeTransaction(transaction);
                  },
                  onReorder: (int oldIndex, int newIndex) {
                    ref
                        .read(transactionProvider.notifier)
                        .reorderTransactions(oldIndex, newIndex);
                  },
                ),
              ),
            ],
          ),
          HistoryScreen(
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
