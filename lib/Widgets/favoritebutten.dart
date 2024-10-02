import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppe/Models/ProducModel.dart';
import 'package:shoppe/cubit/favourite_cubit.dart';

import '../Helpers/dio_helper.dart';

class Favoritebutten extends StatelessWidget {
  Color buttonColor = Color(0xff004CFF);
  Product? product;
  Favoritebutten({this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavouriteCubit>();
    DioHelper.inint();
    cubit.getFavouriteList();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteRemovedLoading) {
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }

          return IconButton(
            icon: Icon(Icons.favorite),
            // Full heart icon
            color:  product != null && cubit.favouriteIds.contains(product?.id.toString())
                ? Colors.red
                : Colors.grey, // Icon color
            iconSize: 40.0, // Icon size
            onPressed: () {
              if (product?.id != null) {
                print("============================================== Id ${product!.id.toString()??"id is Null"}");
                cubit.addOrRemoveFromFavourite(product!.id.toString());
              } else {
                print("Error: product.id is null");
              }
            },
          );
        },
      ),
    );
  }
}
