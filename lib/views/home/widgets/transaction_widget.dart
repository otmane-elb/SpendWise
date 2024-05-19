import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    this.isexpense = true,
  });
  final bool isexpense;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          const Icon(Icons.local_grocery_store),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text('Grocery', style: Theme.of(context).textTheme.titleLarge),
              Text(
                'Today',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.greySeeAll),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Text(
            '+\$85.00',
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
