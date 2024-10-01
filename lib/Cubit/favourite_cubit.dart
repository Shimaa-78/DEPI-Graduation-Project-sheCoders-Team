import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoppe/Models/ProducModel.dart';
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

      if (response.data['status']) {
        var productList = response.data['data']['data'];

        for (var item in productList) {
          favourites.add(FavoriteItem.fromJson(item));
          favouriteIds.add(item['product']['id'].toString());
        }

        print("Favourites length = ${favourites.length}");
        emit(FavouriteSuccess());
      } else {
        emit(FavouriteError("Failed to load favorite items"));
      }
    } catch (error) {
      print("Error: ${error.toString()}");
      emit(FavouriteError("An error occurred. Check your internet connection"));
    }
  }
  Future<void> deleteFavouriteProduct(FavoriteItem favouriteItemId) async {
    emit(FavouriteRemovedLoading(favouriteItemId.product.id));
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
      emit(FavouriteRemovedError("An error occurred while deleting the favorite item: ${error.toString()}"));
    }
  }


  void addOrRemoveFromFavourite(String productId) async {
    emit(
        FavouriteAddLoading()); // Indicate loading state when starting the operation

    try {
      bool isFavourite = favouriteIds.contains(productId);
      final response = await DioHelper.postData(
        path: '${KApis.favouritePath}',
        body: {
          'product_id': productId,
        },
      );

      print("API Response: ${response.data}");

      if (response.data['status']) {
        if (isFavourite) {
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
      print("Error: ${error.toString()}");
      emit(FavouriteAddError(
          "An error occurred while updating favorite status. Check your internet connection."));
    }
  }
}

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
//
// import '../Consts/KApis.dart';
// import '../Helpers/dio_helper.dart';
// import '../Models/Favourite.dart';
//
// part 'favourite_state.dart';
//
// class FavouriteCubit extends Cubit<FavouriteState> {
//   FavouriteCubit() : super(FavouriteInitial());
//
//   List<FavoriteItem> favourites = [];
//   Set<String> favouriteIds = {};
//
//   Future<void> getFavouriteList() async {
//     favourites.clear();
//     emit(FavouriteLoading());
//
//     try {
//       final response = await DioHelper.getData(path: KApis.favouritePath);
//       print("API Response: ${response.data}");
//
//       if (response.data['status']) {
//         var productList = response.data['data']['data']; // Adjust based on the actual response structure
//
//         // Ensure that productList is iterable
//         if (productList is List) {
//           for (var item in productList) {
//             favourites.add(FavoriteItem.fromJson(item));
//             favouriteIds.add(item['product']['id'].toString());
//           }
//         } else {
//           emit(FavouriteError("Unexpected data format received"));
//           return;
//         }
//
//         print("Favourites length = ${favourites.length}");
//         emit(FavouriteSuccess());
//       } else {
//         emit(FavouriteError("Failed to load favorite items"));
//       }
//     } catch (error) {
//       print("Error: ${error.toString()}");
//       emit(FavouriteError("An error occurred. Check your internet connection"));
//     }
//   }
//
//   Future<void> deleteFavouriteProduct(int favouriteItemId) async {
//     emit(FavouriteRemovedLoading());
//     try {
//       final response = await DioHelper.deleteData(
//         path: '${KApis.favouritePath}/$favouriteItemId',
//       );
//
//       if (response.data['status']) {
//         favourites.removeWhere((favItem) => favItem.product.id == favouriteItemId.toString());
//         favouriteIds.remove(favouriteItemId.toString());
//         emit(FavouriteRemovedSuccess());
//       } else {
//         emit(FavouriteRemovedError("Failed to delete favorite item"));
//       }
//     } catch (error) {
//       emit(FavouriteRemovedError("An error occurred while deleting the favorite item: ${error.toString()}"));
//     }
//   }
//
//   Future<void> addOrRemoveFromFavourite(String productId) async {
//     emit(FavouriteRemovedLoading());
//
//     try {
//       bool isFavourite = favouriteIds.contains(productId);
//       final response = await DioHelper.postData(
//         path: '${KApis.favouritePath}',
//         body: {
//           'product_id': productId,
//         },
//       );
//
//       print("API Response: ${response.data}");
//
//       if (response.data['status']) {
//         if (isFavourite) {
//           favouriteIds.remove(productId);
//           print('Product removed from favorites');
//         } else {
//           favouriteIds.add(productId);
//           print('Product added to favorites');
//         }
//         emit(FavouriteRemovedSuccess());
//       } else {
//         emit(FavouriteRemovedError("Failed to update favorite status: ${response.data['message']}"));
//       }
//     } catch (error) {
//       print("Error: ${error.toString()}");
//       emit(FavouriteRemovedError("An error occurred while updating favorite status. Check your internet connection."));
//     }
//   }
// }
