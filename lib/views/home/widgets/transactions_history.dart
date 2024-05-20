import 'package:flutter/material.dart';
import 'package:spendwise/views/home/widgets/transaction_widget.dart';
import '../../../core/models/transaction_model/transaction_model.dart';
import '../../themes/app_colors.dart';
import '../../widgets/confirmation_popup.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({
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
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDialog(
                            title: 'Delete confirmation',
                            content:
                                'Are you sure you want to delete this transaction?',
                            onConfirm: () {
                              onDismissed(transaction);
                            },
                          );
                        },
                      );
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
