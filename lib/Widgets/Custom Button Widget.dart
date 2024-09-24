import 'package:flutter/material.dart';
import 'package:shoppe/Consts.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key,required this.ontap});
  VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 400,
        height: 65,
        child: Center(
          child: Text(
            "Let's get started",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "NunitoSans",
              fontWeight: FontWeight.w300,
              fontSize: 22,
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: KPrimeryColor, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
