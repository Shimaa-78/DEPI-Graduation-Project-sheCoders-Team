import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations.of(context)!.no_favorites_yet,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color:KPrimeryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.add_some_products_to_your_favorites,
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