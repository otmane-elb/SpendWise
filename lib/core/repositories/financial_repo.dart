import '../models/financial_data_model/financial_data.dart';
import '../models/transaction_model/transaction_model.dart';

class FinanceRepository {
  FinancialData _financialData =
      const FinancialData(balance: 0, income: 0, expense: 0);
  final List<Transaction> _transactions = [];

  FinancialData get financialData => _financialData;
  List<Transaction> get transactions => _transactions;

  void updateFinancialData(FinancialData newFinancialData) {
    _financialData = newFinancialData;
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    if (transaction.isExpense) {
      _financialData = _financialData.copyWith(
        expense: _financialData.expense + transaction.value,
        balance: _financialData.balance - transaction.value,
      );
    } else {
      _financialData = _financialData.copyWith(
        income: _financialData.income + transaction.value,
        balance: _financialData.balance + transaction.value,
      );
    }
  }

  void removeTransaction(String id) {
    final transaction = _transactions.firstWhere((t) => t.id == id);
    _transactions.removeWhere((t) => t.id == id);
    if (transaction.isExpense) {
      _financialData = _financialData.copyWith(
        expense: _financialData.expense - transaction.value,
        balance: _financialData.balance + transaction.value,
      );
    } else {
      _financialData = _financialData.copyWith(
        income: _financialData.income - transaction.value,
        balance: _financialData.balance - transaction.value,
      );
    }
  }
}
