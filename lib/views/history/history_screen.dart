import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spendwise/views/history/widgets/filters.dart';
import 'package:spendwise/views/history/widgets/transactions_chart.dart';
import 'package:spendwise/views/home/widgets/transactions_history.dart';
import '../../core/models/transaction_model/transaction_model.dart';
import '../../core/providers/transaction_provider.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  final Function(Transaction) onDismissed;

  const HistoryScreen({
    super.key,
    required this.onDismissed,
  });

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends ConsumerState<HistoryScreen> {
  String _selectedSorting = 'DateAsc';
  bool _showIncome = true;
  bool _showExpense = true;
  late List<Transaction> transactions;

  @override
  void initState() {
    super.initState();
    transactions = ref.read(transactionProvider);
  }

  List<Transaction> getFilteredTransactions() {
    List<Transaction> filteredTransactions = transactions;

    if (!_showIncome) {
      filteredTransactions =
          filteredTransactions.where((t) => t.isExpense).toList();
    }

    if (!_showExpense) {
      filteredTransactions =
          filteredTransactions.where((t) => !t.isExpense).toList();
    }

    if (_selectedSorting == 'DateAsc') {
      filteredTransactions.sort((a, b) => a.date.compareTo(b.date));
    } else if (_selectedSorting == 'DateDesc') {
      filteredTransactions.sort((a, b) => b.date.compareTo(a.date));
    } else if (_selectedSorting == 'ValueAsc') {
      filteredTransactions.sort((a, b) => a.value.compareTo(b.value));
    } else if (_selectedSorting == 'ValueDesc') {
      filteredTransactions.sort((a, b) => b.value.compareTo(a.value));
    }
    return filteredTransactions;
  }

  @override
  Widget build(BuildContext context) {
    transactions = ref.watch(transactionProvider);
    List<Transaction> filteredTransactions = getFilteredTransactions();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: filteredTransactions.isNotEmpty
                ? SimpleLineChart(transactions: filteredTransactions)
                : Container(),
          ),
          const SizedBox(
            height: 50,
          ),
          SortFilterDropdown(
            sortingValue: _selectedSorting,
            showIncome: _showIncome,
            showExpense: _showExpense,
            onSortingChanged: (value) {
              setState(() {
                _selectedSorting = value!;
              });
            },
            onIncomeChanged: (value) {
              setState(() {
                _showIncome = value!;
              });
            },
            onExpenseChanged: (value) {
              setState(() {
                _showExpense = value!;
              });
            },
          ),
          Expanded(
            child: TransactionHistory(
              transactions: filteredTransactions,
              onDismissed: widget.onDismissed,
              onReorder: (int oldIndex, int newIndex) {},
            ),
          ),
        ],
      ),
    );
  }
}
