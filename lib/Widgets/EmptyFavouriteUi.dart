import 'package:flutter/material.dart';

import '../Consts/Consts.dart';
class EmptyFavourite extends StatelessWidget {
  const EmptyFavourite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: KPrimeryColor,
          ),
          SizedBox(height: 16),
          Text(
            'No favorites yet!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color:KPrimeryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add some products to your favorites.',
            style: TextStyle(
              fontSize: 16,
              color:KPrimeryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}