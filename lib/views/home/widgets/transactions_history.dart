import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/views/home/widgets/transaction_widget.dart';
import '../../../core/models/transaction_model/transaction_model.dart';
import '../../../core/routes/app_routes.dart';
import '../../themes/app_colors.dart';
import '../../widgets/confirmation_popup.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({
    super.key,
    required this.transactions,
    required this.onDismissed,
    this.onTap,
  });

  final List<Transaction> transactions;
  final Function(Transaction) onDismissed;
  final Function()? onTap;

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
                  '',
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
                    child: TransactionWidget(
                        onTap: () {
                          context.pushNamed(AppRoutes.transactionDetails,
                              pathParameters: {'id': transaction.id});
                        },
                        transaction: transaction),
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
