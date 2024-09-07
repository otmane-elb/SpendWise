import 'dart:collection';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spendwise/core/providers/transaction_provider.dart';
import '../models/financial_data_model/financial_data.dart';
import '../models/transaction_model/transaction_model.dart';

class FinancialDataNotifier extends StateNotifier<Map<String, FinancialData>> {
  FinancialDataNotifier(List<Transaction> transactions)
      : super(SplayTreeMap<String, FinancialData>()) {
    _calculateMonthlyFinancialData(transactions);
    _updateWidget();
  }

  static const platform = MethodChannel('com.otmane.spendwise/widget');

  void _calculateMonthlyFinancialData(List<Transaction> transactions) {
    final monthlyData = SplayTreeMap<String, FinancialData>();

    for (var transaction in transactions) {
      final month =
          "${transaction.date.year}-${transaction.date.month.toString().padLeft(2, '0')}";

      if (!monthlyData.containsKey(month)) {
        monthlyData[month] = const FinancialData(balance: 0, income: 0, expense: 0);
      }

      final data = monthlyData[month]!;

      final newIncome =
          transaction.isExpense ? data.income : data.income + transaction.value;
      final newExpense = transaction.isExpense
          ? data.expense + transaction.value
          : data.expense;
      final newBalance = newIncome - newExpense;

      // Create a new instance of FinancialData with the updated values
      monthlyData[month] = FinancialData(
        balance: newBalance,
        income: newIncome,
        expense: newExpense,
      );
    }

    state = monthlyData;
  }

  void updateTransactions(List<Transaction> transactions) {
    _calculateMonthlyFinancialData(transactions);
    _updateWidget();
  }

  Future<void> _updateWidget() async {
    // Widget update logic, if applicable
  }
}

final financialDataProvider =
    StateNotifierProvider<FinancialDataNotifier, Map<String, FinancialData>>(
        (ref) {
  final transactions = ref.watch(transactionProvider);
  return FinancialDataNotifier(transactions);
});
