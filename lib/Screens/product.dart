import 'package:flutter/material.dart';
import '../Widgets/productdetails.dart';
import '../Models/ProducModel.dart';
import '../Widgets/Row.dart';
import '../Widgets/productdetails.dart';

class Productveiw extends StatelessWidget {
  final Product product;  // Non-nullable
  Productveiw({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Productdetails(product: product),

          Rowbar(product: product),
        ],
      ),
    );

  }
}
