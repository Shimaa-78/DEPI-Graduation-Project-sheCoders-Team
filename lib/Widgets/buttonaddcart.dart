import 'package:flutter/material.dart';

class Buttonaddcart extends StatelessWidget {
  Color buttonColor = Color(0xff004CFF);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        "Add to Cart",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 50), // عرض وارتفاع الزر
        backgroundColor: buttonColor, // لون الزر
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // تقليل نصف القطر هنا
        ),
      ),
    );}}