import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  Widget label;
  Color color;
  String? Function(String?) validator;
  IconData icon;
  final Color? suffixIconColor;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType textInputType;

  CustomTextFromField(
      {this.color = Colors.black,
      this.suffixIcon,
      this.suffixIconColor = Colors.black,
      required this.textInputType,
      this.textInputAction = TextInputAction.next,
      required this.label,
      required this.validator,
      this.controller,
      required this.icon,
      this.isPassword = false,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 1),
            suffixIcon: suffixIcon != null
                ? IconTheme(
                    data: IconThemeData(
                        color: suffixIconColor), // تعيين اللون هنا
                    child: suffixIcon!, // استخدام الـ suffixIcon الممرر
                  )
                : null,
            prefixIcon: Container(
              margin: EdgeInsets.only(right: 17, top: 6, bottom: 6),
              padding: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey)),
              ),
              child: Icon(
                icon,
                color: Colors.black,
              ),
            ),
            label: label,
            labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            errorBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red))),
        keyboardAppearance: Brightness.light,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        textInputAction: isPassword ? TextInputAction.done : textInputAction,
        keyboardType: textInputType,
      ),
    );
  }
}
