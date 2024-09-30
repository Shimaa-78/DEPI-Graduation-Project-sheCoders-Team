
import 'package:flutter/material.dart';
import 'buttonaddcart.dart';
import 'favoritebutten.dart';

class  Rowbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Favoritebutten(),
        SizedBox(width: 60,),
        Buttonaddcart(),

      ],
    );}}






