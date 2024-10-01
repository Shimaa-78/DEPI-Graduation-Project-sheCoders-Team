import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppe/Models/ProducModel.dart';
import 'package:shoppe/cubit/favourite_cubit.dart';

class Favoritebutten extends StatelessWidget {
  Color buttonColor = Color(0xff004CFF);
 Product product;
  Favoritebutten({required this.product});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavouriteCubit>();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if(state is FavouriteRemovedLoading){
            return Center(
              child: CircularProgressIndicator(
                  strokeWidth:2
              ),

            );
          }
          return IconButton(
            icon: Icon(Icons.favorite),
            // أيقونة القلب الممتلئ
            color: cubit.favouriteIds.contains(product.id.toString())?
            Colors.red:Colors.grey, // لون الأيقونة
            iconSize: 40.0, // حجم الأيقونة
            onPressed: () {
                  cubit.addOrRemoveFromFavourite(product.id.toString());
            },
          );
        },
      ),
    );
  }
}