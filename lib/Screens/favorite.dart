import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/cubit/favourite_cubit.dart';

import '../Helpers/dio_helper.dart';
import '../Widgets/EmptyFavouriteUi.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavouriteCubit>();
    DioHelper.inint();
    cubit.getFavouriteList();

    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return _buildLoadingIndicator();
          }

          if (cubit.favourites.isEmpty) {
            return EmptyFavourite();
          }

          return _buildFavoritesGrid(cubit);
        },
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


  GridView _buildFavoritesGrid(FavouriteCubit cubit) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: cubit.favourites.length,
      itemBuilder: (context, index) {
        return _buildFavoriteCard(cubit, index);
      },
    );
  }

  Widget _buildFavoriteCard(FavouriteCubit cubit, int index) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        if (state is FavouriteRemovedLoading &&
            state.id == cubit.favourites[index].id) {
          return (Center(child: CircularProgressIndicator(),));
        }
        return Card(
          elevation: 4.0,
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFavoriteImage(cubit.favourites[index].product.image),
              _buildFavoriteName(cubit.favourites[index].product.name),
              _buildFavoritePriceAndActions(cubit, index),
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

  Padding _buildFavoritePriceAndActions(FavouriteCubit cubit, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFavoritePrice(cubit.favourites[index].product.price.toString()),
          _buildFavoriteAction(cubit, index),
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

  Widget _buildFavoriteAction(FavouriteCubit cubit, int index) {
    return InkWell(
      onTap: () {
        cubit.deleteFavouriteProduct(cubit.favourites[index]);
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: BlocBuilder<FavouriteCubit,FavouriteState>(
          builder: (context, state) {
            return Icon(
                Icons.favorite,
                color:
                cubit.favouriteIds.contains(
                    cubit.favourites[index].product.id.toString()) ?
                Colors.red : Colors.grey

            );
          },
        ),
      ),
    );
  }
}

