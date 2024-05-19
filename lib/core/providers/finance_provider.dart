import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/financial_data_model/financial_data.dart';
import '../models/transaction_model/transaction_model.dart';
import '../repositories/financial_repo.dart';

final financeRepositoryProvider = Provider<FinanceRepository>((ref) {
  return FinanceRepository();
});

final financialDataProvider = StateNotifierProvider<FinancialDataNotifier, FinancialData>((ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return FinancialDataNotifier(repository);
});

final transactionProvider = StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return TransactionNotifier(repository);
});

class FinancialDataNotifier extends StateNotifier<FinancialData> {
  FinancialDataNotifier(this.repository) : super(repository.financialData);

  final FinanceRepository repository;

  void updateFinancialData(FinancialData newFinancialData) {
    repository.updateFinancialData(newFinancialData);
    state = repository.financialData;
  }
}

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier(this.repository) : super(repository.transactions);

  final FinanceRepository repository;

  void addTransaction(Transaction transaction) {
    repository.addTransaction(transaction);
    state = [...repository.transactions];
  }

  void removeTransaction(String id) {
    repository.removeTransaction(id);
    state = [...repository.transactions];
  }
}
