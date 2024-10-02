import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppe/Models/ProducModel.dart';
import 'package:shoppe/cubit/favourite_cubit.dart';

import '../Helpers/dio_helper.dart';

class Favoritebutten extends StatelessWidget {
  Color buttonColor = Color(0xff004CFF);
  Product product;

  Favoritebutten({required this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavouriteCubit>();
    DioHelper.inint();
    cubit.getFavouriteList();
    return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: IconButton(
          icon: BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (context, state) {
              if (state is FavouriteAddLoading) {
                return Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }
              return Icon(
                Icons.favorite,
                color: cubit.favouriteIds.contains(product.id.toString())
                    ? Colors.red
                    : Colors.grey,
                size: 40.0,
              );
            },
          ),
          onPressed: () {
            cubit.addOrRemoveFromFavourite(productId: product.id.toString());

          },
        ));
  }
}
