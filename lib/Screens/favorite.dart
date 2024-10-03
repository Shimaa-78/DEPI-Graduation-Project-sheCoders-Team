import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/cubit/favourite_cubit.dart';

import '../Helpers/dio_helper.dart';
import '../Models/Favourite.dart';
import '../Widgets/EmptyFavouriteUi.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavouriteCubit>();
    DioHelper.inint();
    cubit.getFavouriteList();
    return BlocListener<FavouriteCubit, FavouriteState>(
  listener: (context, state) {
    if (state is FavouriteError) {
      Get.snackbar(
        "Error",
        state.message ?? "An error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  },
  child: Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return _buildLoadingIndicator();
          }
          print(state);

          return _buildCartSuccessContent(cubit);
        },
      ),
    ),
);
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text('Favorites', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Center _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }
  Widget _buildCartSuccessContent(FavouriteCubit cubit) {
    final favouriteProductsList = cubit.favouriteModel?.items ?? [];


    return favouriteProductsList.length == 0
        ? EmptyFavourite()
        : _buildFavoritesGrid(cubit,favouriteProductsList);
  }

  GridView _buildFavoritesGrid(FavouriteCubit cubit,List<FavoriteItem> favouriteProductsList) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: favouriteProductsList.length,
      itemBuilder: (context, index) {
        return _buildFavoriteCard(cubit,favouriteProductsList, index);
      },
    );
  }

  Widget _buildFavoriteCard(FavouriteCubit cubit,List<FavoriteItem> favouriteProductsList, int index) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        if(state is FavouriteRemovedLoading && state.id == favouriteProductsList[index].product.id){
          return(Center(child: CircularProgressIndicator(),));

        }
        return Card(
          elevation: 4.0,
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFavoriteImage(favouriteProductsList[index].product.image),
              _buildFavoriteName(favouriteProductsList[index].product.name),
              _buildFavoritePriceAndActions(cubit,favouriteProductsList, index),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFavoriteImage(String? imageUrl) {
    return Image.network(
      imageUrl ?? "",
      height: 130.0,
      width: 180,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) =>
      const Icon(Icons.error),
    );
  }

  Padding _buildFavoriteName(String? name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text(
        name ?? "",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: "NunitoSans",
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Padding _buildFavoritePriceAndActions(FavouriteCubit cubit,List<FavoriteItem> favouriteProductsList, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFavoritePrice(favouriteProductsList[index].product.price.toString()),
          _buildFavoriteAction(cubit,favouriteProductsList, index),
        ],
      ),
    );
  }

  Text _buildFavoritePrice(String? price) {
    return Text(
      '\$${price ?? ""}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        fontFamily: "Raleway",
      ),
    );
  }

  Widget _buildFavoriteAction(FavouriteCubit cubit,List<FavoriteItem> favouriteProductsList, int index) {
    return InkWell(
      onTap: () {
        cubit.deleteFavouriteProduct(favouriteProductsList[index]);

      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
            Icons.favorite,
            color:

            Colors.red

        ),
      ),
    );
  }
}