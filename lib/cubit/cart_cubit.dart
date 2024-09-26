import 'package:bloc/bloc.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:meta/meta.dart';
import 'package:shoppe/Consts/Kpis.dart';

import '../Helpers/DioHelper.dart';
import '../Models/CartModel.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartModel? cartModel;
  List<CartModel> cartItems = [];

  CartCubit() : super(CartInitial());

  int? total;
  Set<String> cartIds = {};
  Future<void> getUserCart() async {
    emit(CartLoading());
    try {
      final response = await DioHelper.getData(path: KApis.cartPath);
      print("API Response: ${response.data}");

      if (response.data['status']) {
        cartModel = CartModel.fromJson(response.data);

        // cartIds.clear();
        for (var item in cartModel!.cartItems) {
          cartIds.add(item.product.id.toString());
        }

        total = response.data['data']['total'].toInt();
        emit(CartSuccess());
      } else {
        emit(CartError("Failed to load cart items"));
      }
    } catch (error) {
      print(error.toString());
      emit(CartError("An error occurred Check Your Internet Connection"));
    }
  }

  void addOrRemoveFromTheCart(String productId) async {
    // Change type to int
    emit(CartLoading());
    try {
      final response = await DioHelper.postData(path: KApis.cartPath, body: {
        'product_id': productId.toString(), // Convert to string for the request
      });
      print("API Response: ${response.data}");

      if (response.data['status']) {
        // Check if the product ID is already in the set
        if (cartIds.contains(productId)) {
          cartIds.remove(productId); // Remove if already in the cart
        } else {
          cartIds.add(productId.toString()); // Add if not in the cart
        }
        await getUserCart();
        emit(CartSuccess());
      } else {
        // Refresh cart if the operation fails
        emit(CartError("Failed to load cart items"));
      }
    } catch (error) {
      print(error.toString());
      emit(CartError("An error occurred Check Your Internet Connection"));
    }
  }
  Future<void> incrementQuantity(CartItem item) async {
    int newQuantity = item.quantity + 1;

    emit(updateCartLoading());
    try {
      final response = await DioHelper.putData(
        path: '${KApis.cartPath}/${item.id}',
        body: {'quantity': newQuantity},
      );
      if (response.data['status']) {

        await getUserCart();
        print("+====================================================${item.id}");
        emit(CartSuccess());
      } else {
        emit(CartError(response.data['message'] ?? "Failed to update cart item"));
      }
    } catch (error) {
      emit(CartError("An error occurred Check Your Internet Connection"));
    }
  }

  Future<void> decrementQuantity(CartItem item) async {
    if (item.quantity > 1) {
      int newQuantity = item.quantity - 1;

      emit(updateCartLoading());
      try {
        final response = await DioHelper.putData(
          path: '${KApis.cartPath}/${item.id}',
          body: {'quantity': newQuantity},
        );
        if (response.data['status']) {
          await getUserCart();


          emit(CartSuccess());
        } else {
          emit(CartError(response.data['message'] ?? "Failed to update cart item"));
        }
      } catch (error) {
        emit(CartError("An error occurred Check Your Internet Connection"));
      }
    }
  }
  Future<void> clearCart() async {
    emit(CartLoading());

    try {
      // Assuming you have a list of cart items
      for (var item in cartModel?.cartItems ?? []) {
        final response = await DioHelper.deleteData(
          path: '${KApis.cartPath}/${item.id}', // Endpoint for deleting a cart item
        );

        if (!response.data['status']) {
          emit(CartError(response.data['message'] ?? "Failed to delete cart item"));
          return; // Exit the loop if any deletion fails
        }
      }

      // Optionally, refresh the cart after clearing
      await getUserCart();
      emit(CartSuccess()); // Emit success state

    } catch (error) {
      emit(CartError("An error occurred while clearing the cart"));
    }
  }
}