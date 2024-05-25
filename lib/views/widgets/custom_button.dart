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
  final bool isWhite;

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
    this.isWhite = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isWhite
        ? AppColors.white
        : (backgroundColor ?? AppColors.primaryLightColor);
    final txtColor =
        isWhite ? AppColors.primaryColor : (textColor ?? AppColors.white);
    final brdColor =
        isWhite ? AppColors.primaryColor : (borderColor ?? Colors.transparent);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: brdColor,
          width: 1.0,
        ),
        borderRadius: radius != null
            ? BorderRadius.circular(radius!)
            : BorderRadius.circular(30),
        boxShadow: shadows
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
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
            backgroundColor: bgColor,
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
                            color: txtColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                    )
                  ],
                  if (isLoading) ...[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: CupertinoActivityIndicator(
                        color: txtColor,
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
