import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spendwise/views/themes/app_colors.dart';

class TransactionPlaceholder extends StatelessWidget {
  const TransactionPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: AppColors.primaryLightColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.0,
                  height: 20.0,
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 80.0,
                  height: 20.0,
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Container(
              width: 80.0,
              height: 20.0,
              color: AppColors.primaryColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
