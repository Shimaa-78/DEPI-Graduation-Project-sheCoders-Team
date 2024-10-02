import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../Consts/KApis.dart';
import '../Helpers/dio_helper.dart';
import '../Models/Favourite.dart';
part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  List<FavoriteItem> favourites = [];
  Set<String> favouriteIds = {};
  FavoriteItem ?favouriteItem;

  Future<void> getFavouriteList() async {
    favourites.clear();
    emit(FavouriteLoading());

    try {
      final response = await DioHelper.getData(path: KApis.favouritePath);
      print("API Response: ${response.data}");

      if (response.data?['status'] == true && response.data?['data']?['data'] != null) {
        var productList = response.data['data']['data'];
        for (var item in productList) {
          if (item != null && item['product'] != null) {
            favourites.add(FavoriteItem.fromJson(item));
            favouriteIds.add(item['product']['id'].toString());
          }
        }
      } else {
        emit(FavouriteError("Failed to load favorite items or data is null"));
      }
    } catch (error) {
      print("Error: ${error.toString()}");
      emit(FavouriteError("An error occurred. Check your internet connection"));
    }
  }

  Future<void> deleteFavouriteProduct(FavoriteItem favouriteItemId) async {
    if (favouriteItemId?.product?.id != null) {
      emit(FavouriteRemovedLoading(favouriteItemId.product.id));
    } else {
      emit(FavouriteRemovedError("Invalid product data"));
    }

    try {
      final response = await DioHelper.deleteData(
        path: '${KApis.favouritePath}/${favouriteItemId.id}',
      );

      if (response.data['status']) {
        // Optionally, remove the item from the local list if necessary
        favourites.removeWhere((favItem) => favItem.id == favouriteItemId.id);
        favouriteIds.remove(favouriteItemId.product.id);

        emit(FavouriteRemovedSuccess());
      } else {
        emit(FavouriteRemovedError("Failed to delete favorite item"));
      }
    } catch (error) {
      emit(FavouriteRemovedError(
          "An error occurred while deleting the favorite item: ${error
              .toString()}"));
    }
  }

  void addOrRemoveFromFavourite(String productId) async {
    print(productId);
    emit(
        FavouriteAddLoading()); // Indicate loading state when starting the operation

    try {
      bool isFavourite = false;
       isFavourite = favouriteIds.contains(productId);

          final response = await DioHelper.postData(
        path: '${KApis.favouritePath}',
        body: {
          'product_id': productId,
        },
      );

      print("API Response: ${response.data}");

      if (response.data != null && response.data['status'] == true) {
        if (isFavourite) {
          favouriteIds.remove(productId);
          print('Product removed from favorites');
        } else {
          favouriteIds.add(productId);
          print('Product added to favorites');
        }
        await getFavouriteList();
        emit(FavouriteAddSuccess());
      } else {
        emit(FavouriteAddError(
            "Failed to update favorite status: ${response.data?['message'] ??
                'Unknown error'}"));
      }
    } catch (error) {
      print("Catch Error: ${error.toString()}");
      emit(FavouriteAddError(
          "An error occurred while updating favorite status. Check your internet connection."));
    }
  }
}
