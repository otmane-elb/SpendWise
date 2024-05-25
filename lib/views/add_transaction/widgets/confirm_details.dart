import 'package:flutter/material.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import 'package:spendwise/views/widgets/custom_button.dart';

class ConfirmDetailsDialog extends StatefulWidget {
  final String totalAmount;
  final String date;
  final Function(bool, bool) onConfirm;

  const ConfirmDetailsDialog({
    super.key,
    required this.totalAmount,
    required this.date,
    required this.onConfirm,
  });

  @override
  ConfirmDetailsDialogState createState() => ConfirmDetailsDialogState();
}

class ConfirmDetailsDialogState extends State<ConfirmDetailsDialog> {
  bool confirmAmount = true;
  bool confirmDate = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primaryLightColor,
      title: Center(
        child: Text(
          'Confirm Details',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: Text(
              'Amount: ${widget.totalAmount}',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: AppColors.white),
            ),
            value: confirmAmount,
            onChanged: (bool? value) {
              setState(() {
                confirmAmount = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              'Date: ${widget.date}',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: AppColors.white),
            ),
            value: confirmDate,
            onChanged: (bool? value) {
              setState(() {
                confirmDate = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(
                isWhite: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Cancel'),
            CustomButton(
                onPressed: () {
                  widget.onConfirm(confirmAmount, confirmDate);
                  Navigator.of(context).pop();
                },
                text: 'Save'),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info,
              color: AppColors.beige,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Attention The Data may be incorrect',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 10),
            ),
          ],
        )
      ],
    );
  }
}
