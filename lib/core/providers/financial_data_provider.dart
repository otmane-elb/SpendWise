import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/financial_data_model/financial_data.dart';



class FinancialDataNotifier extends StateNotifier<FinancialData> {
  FinancialDataNotifier()
      : super(const FinancialData(balance: 0, income: 0, expense: 0));

  void updateBalance(double newBalance) {
    state = state.copyWith(balance: newBalance);
  }

  void updateIncome(double newIncome) {
    state = state.copyWith(income: newIncome);
  }

  void updateExpense(double newExpense) {
    state = state.copyWith(expense: newExpense);
  }
}

final financialDataProvider =
    StateNotifierProvider<FinancialDataNotifier, FinancialData>((ref) {
  return FinancialDataNotifier();
});
