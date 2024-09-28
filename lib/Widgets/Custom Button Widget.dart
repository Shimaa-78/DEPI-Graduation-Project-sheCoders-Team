import 'package:flutter/material.dart';
import 'package:shoppe/Consts/Kcolors.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
        required this.ontap,
        required this.width,
        required this.text,
        required this.height,
        required this.fontsize});
  VoidCallback ontap;
  double width;
  String text;
  double height;
  double fontsize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        child: Center(
          child: Text(
            "$text",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "NunitoSans",
              fontWeight: FontWeight.w300,
              fontSize: this.fontsize,
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: KPrimeryColor, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}