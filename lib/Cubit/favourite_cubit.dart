import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../Consts/KApis.dart';
import '../Helpers/dio_helper.dart';
import '../Models/Favourite.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  // List<FavoriteItem> favourites = [];
  Set<String> favouriteIds = {};
  FavouriteModel? favouriteModel;
  Future<void> getFavouriteList() async {
    favouriteModel?.items.clear();
    emit(FavouriteLoading());

    try {
      final response = await DioHelper.getData(path: KApis.favouritePath);
      print("API Response: ${response.data}");

      if (response.data['status']) {

        favouriteModel = FavouriteModel.fromJson(response.data['data']);
        for (var item in favouriteModel!.items) {
          favouriteIds.add(item.product.id.toString());
        }

        print("Favourites length = ${favouriteModel?.items.length}");
        emit(FavouriteSuccess());
      } else {
        emit(FavouriteError("Failed to load favorite items"));
      }
    } catch (error) {
      print("Error: ${error.toString()}");
      emit(FavouriteError("An error occurred. Check your internet connection"));
    }
  }

  Future<void> deleteFavouriteProduct(FavoriteItem favouriteItem) async {
    emit(FavouriteRemovedLoading(favouriteItem.product.id));
    try {
      final response = await DioHelper.deleteData(
        path: '${KApis.favouritePath}/${favouriteItem.id}',
      );

      if (response.data['status']) {
        favouriteModel?.items.remove(favouriteItem);
        favouriteIds.remove(favouriteItem.product.id.toString());
        print("inside the delete function ${favouriteIds.contains(favouriteItem.product.id)}");

        emit(FavouriteRemovedSuccess());
      } else {
        emit(FavouriteRemovedError("Failed to delete favorite item"));
      }
    } catch (error) {
      print(error.toString());
      emit(FavouriteRemovedError(
          "An error occurred while deleting the favorite item: ${error.toString()}"));
    }
  }


  void addOrRemoveFromFavourite({required String productId}) async {
    emit(FavouriteAddLoading());

    try {
      final response = await DioHelper.postData(
        path: '${KApis.favouritePath}',
        body: {
          'product_id': productId,
        },
      );

      print("API Response: ${response.data}");

      if (response.data['status']) {
        if (favouriteIds.isNotEmpty && favouriteIds.contains(productId)) {
          favouriteIds.remove(productId);
          print('Product removed from favorites');
        } else {
          favouriteIds.add(productId);
          print('Product added to favorites');
        }

        emit(FavouriteAddSuccess()); // Emit success state
      } else {
        emit(FavouriteAddError(
            "Failed to update favorite status: ${response.data['message']}"));
      }
    } catch (error) {
      print("Catch Error: ${error.toString()}");
      emit(FavouriteAddError(
          "An error occurred while updating favorite status. Check your internet connection."));
    }
  }
}