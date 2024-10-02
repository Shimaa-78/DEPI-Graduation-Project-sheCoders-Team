import 'package:flutter/material.dart';
import '../Models/ProducModel.dart';
import 'buttonaddcart.dart';
import 'favoritebutten.dart';

class Rowbar extends StatelessWidget {
  final Product product;  // Non-nullable
  Rowbar({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Favoritebutten(product: product),  // Passing the product (nullable)
        SizedBox(width: 60),
        Buttonaddcart(product: product),   // Non-nullable
      ],
    );
  }
}
