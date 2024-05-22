import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/core/models/transaction_model/transaction_model.dart';
import 'package:spendwise/utils/extentions/format_currency.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import 'package:spendwise/views/widgets/icon_display.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final iconData = getIconDataFromString(transaction.icon);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              decoration:
                  const BoxDecoration(color: AppColors.primaryLightColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Transacion Details',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Icon(
                    Icons.more_horiz,
                    color: AppColors.white,
                    size: 35,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            iconData != null
                ? FaIcon(
                    iconData,
                    color: AppColors.primaryLightColor,
                    size: 35,
                  )
                : const FaIcon(
                    FontAwesomeIcons.moneyBill1Wave,
                    color: AppColors.primaryLightColor,
                  ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: transaction.isExpense
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                          color: AppColors.red.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Expense',
                        style: TextStyle(color: AppColors.red),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Income',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
            ),
            Text(
              '\$${FormatStyles().formatCurrency(transaction.value)} ',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction details ',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Status',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Date',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        transaction.isExpense ? 'To' : 'From',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColors.black),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '^',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: transaction.isExpense
                            ? const Text(
                                'Expense',
                                style: TextStyle(color: AppColors.red),
                              )
                            : const Text(
                                'Income',
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        FormatStyles().formatDate(transaction.date),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        transaction.title,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColors.black),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: transaction.image != null
                      ? Image.memory(transaction.image!)
                      : const Text('No invoice')),
            )
          ],
        ),
      ),
    );
  }
}
