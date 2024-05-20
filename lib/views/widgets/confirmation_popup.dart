import 'package:flutter/material.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import 'package:spendwise/views/widgets/custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 2,
      backgroundColor: AppColors.primaryLightColor,
      title: Center(
          child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      )),
      content: Text(
        content,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(
              isWhite: true,
              text: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CustomButton(
              text: 'Confirm',
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
