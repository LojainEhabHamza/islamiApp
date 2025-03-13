import 'package:flutter/material.dart';
import 'package:islami/core/utils/app_colors.dart';
import 'package:islami/core/utils/app_styles.dart';

typedef MyValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  Color? borderColor;
  String? hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  TextStyle? style;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText;
  int? maxLines;
  MyValidator validator;
  TextEditingController? controller;
  TextInputType? keyboardType;
  Function(String?)? onSaved;
  Function(String?)? onChanged;

  CustomTextFormField(
      {
      this.onSaved,
      this.onChanged,
      this.controller,
      this.validator,
      this.borderColor,
      required this.hintText,
      this.labelText,
      this.hintStyle,
      this.labelStyle,
      this.style,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.maxLines,
      this.keyboardType = TextInputType.text
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      obscureText: obscureText,
      obscuringCharacter: '*',
      cursorColor: AppColors.primaryColor,
      style: style ?? AppStyles.bold16White,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle ?? AppStyles.regular16White,
        labelStyle: labelStyle ?? AppStyles.regular16White,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: borderColor ?? AppColors.primaryColor, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: borderColor ?? AppColors.primaryColor, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.redColor, width: 2)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.redColor, width: 2)),
      ),
    );
  }
}
