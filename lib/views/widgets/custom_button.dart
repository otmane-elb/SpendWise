import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? maxWidth;
  final bool isLoading;
  final bool shadows;
  final Function() onPressed;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final double? radius;
  final Color? borderColor;

  const CustomButton({
    super.key,
    this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.isLoading = false,
    this.textStyle,
    this.backgroundColor,
    this.minWidth,
    this.textColor,
    this.maxWidth,
    this.radius,
    this.borderColor,
    this.shadows = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: borderColor != null
              ? Border.all(
                  color: borderColor!,
                )
              : null,
          borderRadius: radius != null ? BorderRadius.circular(radius!) : null,
          boxShadow: shadows
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: const Offset(0, 2),
                  ),
                ]
              : []),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth ?? 90,
          maxWidth: maxWidth ?? double.infinity,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: backgroundColor ?? AppColors.primaryLightColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 30),
            ),
          ),
          onPressed: onPressed,
          child: SizedBox(
            width: width,
            height: height ?? 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (text != null) ...[
                    Text(
                      text!,
                      style: textStyle ??
                          TextStyle(
                            color: textColor ?? AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                    )
                  ],
                  if (isLoading) ...[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const CupertinoActivityIndicator(
                        color: AppColors.white,
                        radius: 15,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
