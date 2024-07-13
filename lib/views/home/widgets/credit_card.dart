import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/extentions/format_currency.dart';
import '../../themes/app_colors.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({
    super.key,
    required this.height,
    required this.balance,
    required this.income,
    required this.expense,
  });

  final double height;
  final double balance;
  final double income;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(left: 20, right: 20, top: height * .15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text('Total Balance :',
                style: Theme.of(context).textTheme.labelLarge),
          ),
          Center(
            child: Text('\$${FormatStyles().formatCurrency(balance)}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: balance < 0 ? AppColors.red : AppColors.white)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.circleArrowUp,
                        size: 15,
                        color: AppColors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Income',
                          style: Theme.of(context).textTheme.labelSmall)
                    ],
                  ),
                  Text('\$${FormatStyles().formatCurrency(income)}',
                      style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.circleArrowDown,
                        size: 15,
                        color: AppColors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Expenses',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Text('\$${FormatStyles().formatCurrency(expense)}',
                      style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ],
          )
        ],
      )),
    );
  }
}
