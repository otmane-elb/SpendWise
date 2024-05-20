import 'package:flutter/material.dart';
import 'package:spendwise/views/home/widgets/transaction_widget.dart';
import '../../../core/models/transaction_model/transaction_model.dart';
import '../../themes/app_colors.dart';

class TransactionsHistory extends StatelessWidget {
  const TransactionsHistory({
    super.key,
    required this.transactions,
    required this.onDismissed,
  });

  final List<Transaction> transactions;
  final Function(Transaction) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transaction History',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                  'See All',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.greySeeAll),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Dismissible(
                    key: Key(transaction.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      onDismissed(transaction);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: TransactionWidget(transaction: transaction),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
