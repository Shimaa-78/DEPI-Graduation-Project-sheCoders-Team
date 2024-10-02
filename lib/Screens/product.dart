import 'package:flutter/material.dart';
import '../Models/ProducModel.dart';
import '../Widgets/Row.dart';
import '../Widgets/productdetails.dart';

class Productveiw extends StatelessWidget {
  final Product product;  // Non-nullable
  Productveiw({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Productdetails(product: product),
          SizedBox(height: 16),
          Rowbar(product: product),
        ],
      ),
    );
  }
}
