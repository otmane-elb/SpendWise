import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spendwise/core/models/transaction_model/transaction_model.dart';
import 'package:spendwise/utils/extentions/format_currency.dart';

import '../../themes/app_colors.dart';
import '../../widgets/icon_display.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.transaction,
    this.onTap,
  });
  final Transaction transaction;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final iconData = getIconDataFromString(transaction.icon);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            iconData != null
                ? FaIcon(
                    iconData,
                    color: AppColors.primaryLightColor,
                  )
                : const FaIcon(
                    FontAwesomeIcons.moneyBill1Wave,
                    color: AppColors.primaryLightColor,
                  ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                  ),
                  Text(
                    FormatStyles().formatDate(transaction.date),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.greySeeAll),
                  ),
                ],
              ),
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
      ),
    );
  }
}
