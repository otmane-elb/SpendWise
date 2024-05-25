import 'package:flutter/material.dart';
import 'package:spendwise/views/themes/app_colors.dart';

class SortFilterDropdown extends StatefulWidget {
  final String sortingValue;
  final bool showIncome;
  final bool showExpense;
  final void Function(String?)? onSortingChanged;
  final void Function(bool?)? onIncomeChanged;
  final void Function(bool?)? onExpenseChanged;

  const SortFilterDropdown({
    super.key,
    required this.sortingValue,
    required this.showIncome,
    required this.showExpense,
    required this.onSortingChanged,
    required this.onIncomeChanged,
    required this.onExpenseChanged,
  });

  @override
  SortFilterDropdownState createState() => SortFilterDropdownState();
}

class SortFilterDropdownState extends State<SortFilterDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text(
                    'Incomes',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  value: widget.showIncome,
                  onChanged: widget.onIncomeChanged,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text(
                    'Expenses',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  value: widget.showExpense,
                  onChanged: widget.onExpenseChanged,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: widget.sortingValue,
              items: [
                DropdownMenuItem(
                  value: 'DateAsc',
                  child: Text(
                    'Sort by Date Ascending',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
                DropdownMenuItem(
                  value: 'DateDesc',
                  child: Text(
                    'Sort by Date Descending',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
                DropdownMenuItem(
                  value: 'ValueAsc',
                  child: Text(
                    'Sort by Value Ascending',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
                DropdownMenuItem(
                  value: 'ValueDesc',
                  child: Text(
                    'Sort by Value Descending',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
              onChanged: widget.onSortingChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.primaryLightColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
