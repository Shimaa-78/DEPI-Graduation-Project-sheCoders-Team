import 'package:flutter/material.dart';
Container CircleLogo(String image) {
  return Container(
    width: 170,
    height: 170,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(200),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 236, 232, 232),
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Image.asset(
      image,
    ),
  );
}
