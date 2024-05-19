import 'package:flutter/material.dart';
import 'package:spendwise/views/themes/app_colors.dart';

class CurvedContainer extends StatelessWidget {
  final Widget child;
  final double height;

  const CurvedContainer({super.key, required this.child, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedClipper(),
      child: Container(
        height: height,
        color: AppColors.primaryLightColor,
        child: child,
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
