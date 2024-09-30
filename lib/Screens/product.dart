import 'package:flutter/material.dart';
import '../Widgets/productdetails.dart';
import '../Models/ProducModel.dart';
import '../Widgets/Row.dart';
class Productveiw extends  StatelessWidget {

   Product product;
   Productveiw({required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

   body:  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Productdetails(product: product),
        SizedBox(height: 16),
        Rowbar(product:product),
        // إضافة مسافة بين النص والزر

      ],
    ));
  }
}
