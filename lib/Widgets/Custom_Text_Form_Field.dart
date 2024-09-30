import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  Widget label;
  Color color;
  String? Function(String?) validator;
  IconData icon;
  TextInputType keyboardTybe;
  bool isObscure;
  IconData? suffixIcon;
  final TextEditingController? controller;

  CustomTextFromField(
      {this.color=Colors.black
        , this.suffixIcon,
        required this.label,
        required this.validator,
        this.controller,
        required this.icon,
        this.keyboardTybe = TextInputType.text,
        this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 1),
            suffixIcon: Icon(
              suffixIcon,
              color: color,
            ),
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
            focusedErrorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red))),
        keyboardType: keyboardTybe,
        keyboardAppearance: Brightness.light,
        controller: controller,
        validator: validator,
        obscureText: isObscure,


      ),
    );
  }
}