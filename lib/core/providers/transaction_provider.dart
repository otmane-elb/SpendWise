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
    List<Transaction> transactions = box.values.toList();

    // Check for transactions without an order field and assign order values
    bool orderNeedsUpdate = false;
    for (int i = 0; i < transactions.length; i++) {
      if (transactions[i].order == null) {
        transactions[i] = transactions[i].copyWith(order: i);
        orderNeedsUpdate = true;
      }
    }

    // If any transaction needed an order update, save them back to Hive
    if (orderNeedsUpdate) {
      for (var transaction in transactions) {
        await box.put(transaction.id, transaction);
      }
    }

    transactions.sort((a, b) => a.order!.compareTo(b.order!));
    state = transactions;
    log('Transactions loaded: ${state.length}');
  }

  Future<void> addTransaction(Transaction transaction) async {
    final box = await Hive.openBox<Transaction>('transactions');

    // Assign the correct order value to the new transaction
    final order = state.length;
    final newTransaction = transaction.copyWith(order: order);

    await box.put(newTransaction.id, newTransaction);
    List<Transaction> transactions = box.values.toList();
    transactions.sort((a, b) => a.order!.compareTo(b.order!));
    state = transactions;
    log('${newTransaction.id} Transaction added successfully');
  }

  Future<void> removeTransaction(Transaction transaction) async {
    final box = await Hive.openBox<Transaction>('transactions');
    await box.delete(transaction.id);

    // Reload the transactions without reassigning order values
    List<Transaction> transactions = box.values.toList();
    transactions.sort((a, b) => a.order!.compareTo(b.order!));
    state = transactions;
    log('${transaction.id} Transaction deleted successfully');
  }

  Future<void> reorderTransactions(int oldIndex, int newIndex) async {
    final box = await Hive.openBox<Transaction>('transactions');
    final transactions = state.toList();

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = transactions.removeAt(oldIndex);
    transactions.insert(newIndex, item);

    // Update the order field and save the reordered list
    for (int i = 0; i < transactions.length; i++) {
      transactions[i] = transactions[i].copyWith(order: i);
    }

    // Update the state immediately
    state = transactions;
    log('Transactions reordered successfully');

    // Save the updated transactions back to Hive
    await Future.wait(transactions
        .map((transaction) => box.put(transaction.id, transaction)));
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionStateNotifier, List<Transaction>>((ref) {
  return TransactionStateNotifier();
});
