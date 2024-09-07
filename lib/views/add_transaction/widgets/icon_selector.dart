import 'package:flutter/material.dart';
import 'package:spendwise/views/widgets/icon_display.dart';

import '../../themes/app_colors.dart';

class IconSelector extends StatelessWidget {
  final IconData? selectedIcon;
  final ValueChanged<IconData> onIconSelected;

  const IconSelector({
    super.key,
    required this.selectedIcon,
    required this.onIconSelected,
  });

  @override
  Widget build(BuildContext context) {
    final icons = iconMap.values.toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        final icon = icons[index];
        return GestureDetector(
          onTap: () => onIconSelected(icon),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: selectedIcon == icon
                  ? AppColors.primaryLightColor
                  : AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: selectedIcon == icon
                    ? AppColors.primaryColor
                    : AppColors.grey400,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: selectedIcon == icon
                  ? AppColors.white
                  : AppColors.primaryColor,
            ),
          ),
        );
      },
    );
  }
}
