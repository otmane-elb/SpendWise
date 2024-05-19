import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../themes/app_colors.dart';
import 'package:intl/intl.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.isPassword = false,
    this.isHiddenPassword = false,
    this.onHiddenPassword,
    this.keyboardType,
    this.validator,
    this.initialValue,
    this.onChanged,
    this.radius = 10,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.contentPadding,
    this.suffixIcon,
    this.isNumber = false,
    this.isDate = false,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool isHiddenPassword;
  final Function(bool)? onHiddenPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final double radius;
  final int? maxLines;
  final Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final bool isNumber;
  final bool isDate;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _controller;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.isDate) {
      _controller.text = _formatDate(_selectedDate);
    } else if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('EEE, dd MMM yyyy').format(date);
  }

  Future<void> _selectDate(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Container(
              height: 180,
              child: CupertinoDatePicker(
                initialDateTime: _selectedDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                    _controller.text = _formatDate(_selectedDate);
                    if (widget.onChanged != null) {
                      widget.onChanged!(_controller.text);
                    }
                  });
                },
              ),
            ),
            CupertinoButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.label!,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.grey400,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        TextFormField(
          controller: _controller,
          obscureText: widget.isPassword && widget.isHiddenPassword,
          keyboardType:
              widget.isNumber ? TextInputType.number : widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLines: widget.maxLines,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14),
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            contentPadding: widget.contentPadding,
            fillColor: const Color(0xFFF9F5F4),
            suffixIcon: widget.suffixIcon ??
                (widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          widget.isHiddenPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.black,
                        ),
                        onPressed: () =>
                            widget.onHiddenPassword!(!widget.isHiddenPassword),
                      )
                    : widget.isDate
                        ? IconButton(
                            icon: const Icon(Icons.calendar_today,
                                color: AppColors.black),
                            onPressed: () => _selectDate(context),
                          )
                        : null),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: const BorderSide(
                color: AppColors.primaryLightColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
