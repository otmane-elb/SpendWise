import 'package:flutter/material.dart';
import 'package:spendwise/core/models/transaction_model/transaction_model.dart';
import 'package:spendwise/utils/extentions/format_currency.dart';

import '../../themes/app_colors.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.transaction,
  });
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                'https://cdn.icon-icons.com/icons2/3053/PNG/512/netflix_macos_bigsur_icon_189917.png',
              ),
            )),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transaction.title,
                  style: Theme.of(context).textTheme.titleLarge),
              Text(
                FormatStyles().formatDate(transaction.date),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.greySeeAll),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          transaction.isExpense
              ? Text(
                  '-\$${FormatStyles().formatCurrency(transaction.value)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.red),
                )
              : Text(
                  '+\$${FormatStyles().formatCurrency(transaction.value)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.green),
                )
        ],
      ),
    );
  }
}
