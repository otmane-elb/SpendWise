import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    final icons = [
      FontAwesomeIcons.house,
      FontAwesomeIcons.utensils,
      FontAwesomeIcons.cartShopping,
      FontAwesomeIcons.gasPump,
      FontAwesomeIcons.lightbulb,
      FontAwesomeIcons.water,
      FontAwesomeIcons.mobileScreenButton,
      FontAwesomeIcons.creditCard,
      FontAwesomeIcons.internetExplorer,
      FontAwesomeIcons.car,
      FontAwesomeIcons.dollarSign,
      FontAwesomeIcons.moneyBill,
      FontAwesomeIcons.school,
      FontAwesomeIcons.tv,
      FontAwesomeIcons.wifi,
      FontAwesomeIcons.bell,
      FontAwesomeIcons.tv,
      FontAwesomeIcons.appleWhole,
      FontAwesomeIcons.book,
      FontAwesomeIcons.mugSaucer,
      FontAwesomeIcons.bus,
      FontAwesomeIcons.heart,
    ];

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
