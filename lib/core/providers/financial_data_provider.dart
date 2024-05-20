import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spendwise/core/providers/transaction_provider.dart';
import '../models/financial_data_model/financial_data.dart';
import '../models/transaction_model/transaction_model.dart';

class FinancialDataNotifier extends StateNotifier<FinancialData> {
  FinancialDataNotifier(List<Transaction> transactions)
      : super(const FinancialData(balance: 0, income: 0, expense: 0)) {
    _calculateFinancialData(transactions);
  }

  void _calculateFinancialData(List<Transaction> transactions) {
    double income = 0;
    double expense = 0;

    for (var transaction in transactions) {
      if (transaction.isExpense) {
        expense += transaction.value;
      } else {
        income += transaction.value;
      }
    }

    double balance = income - expense;

    state = state.copyWith(balance: balance, income: income, expense: expense);
  }

  void updateTransactions(List<Transaction> transactions) {
    _calculateFinancialData(transactions);
  }
}

final financialDataProvider = StateNotifierProvider<FinancialDataNotifier, FinancialData>((ref) {
  final transactions = ref.watch(transactionProvider);
  return FinancialDataNotifier(transactions);
});
