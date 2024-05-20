import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    this.value = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.grey400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButtonFormField<bool>(
            value: value,
            items: const [
              DropdownMenuItem(
                value: true,
                child: Text(
                  'Expense',
                  style: TextStyle(
                      color: AppColors.primaryLightColor, fontSize: 18),
                ),
              ),
              DropdownMenuItem(
                value: false,
                child: Text(
                  'Income',
                  style: TextStyle(
                      color: AppColors.primaryLightColor, fontSize: 18),
                ),
              ),
            ],
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.primaryLightColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
