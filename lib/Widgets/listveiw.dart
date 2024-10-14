import 'package:flutter/material.dart';
import '../Models/ProducModel.dart';
import '../Widgets/productcard.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;

  ProductListView({required this.products});

  @override
  Widget build(BuildContext context) {

    return
      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return  Productcard (product: products[index]);
        },
      );

  }
}