import 'package:flutter/material.dart';
import 'package:spendwise/views/home/widgets/transactions_history.dart';

import '../../core/models/transaction_model/transaction_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    super.key,
    required this.transactions,
    required this.onDismissed,
  });

  final List<Transaction> transactions;
  final Function(Transaction) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          TransactionHistory(
            transactions: transactions,
            onDismissed: onDismissed,
          ),
        ],
      ),
    );
  }
}
