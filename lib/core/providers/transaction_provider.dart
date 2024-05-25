import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model/transaction_model.dart';

class TransactionStateNotifier extends StateNotifier<List<Transaction>> {
  TransactionStateNotifier() : super([]) {
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final box = await Hive.openBox<Transaction>('transactions');
    state = box.values.toList();
  }

  Future<void> addTransaction(Transaction transaction) async {
    final box = await Hive.openBox<Transaction>('transactions');
    await box.put(transaction.id, transaction);
    state = box.values.toList();
    log('${transaction.id} Transaction added successfully');
  }

  Future<void> removeTransaction(Transaction transaction) async {
    final box = await Hive.openBox<Transaction>('transactions');
    await box.delete(transaction.id);
    state = box.values.toList();
    log('${transaction.id} Transaction deleted successfully');
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionStateNotifier, List<Transaction>>((ref) {
  return TransactionStateNotifier();
});
