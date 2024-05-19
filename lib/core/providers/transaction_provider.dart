import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/transaction_model/transaction_model.dart';

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super([]);

  void addTransaction(Transaction transaction) {
    state = [...state, transaction];
  }

  void removeTransaction(String id) {
    state = state.where((transaction) => transaction.id != id).toList();
  }
}

final transactionProvider = StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) {
  return TransactionNotifier();
});
