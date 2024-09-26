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
      emit(CartError("An error occurred"));
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
      emit(CartError("An error occurred"));
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
        item.quantity = newQuantity;
        emit(CartUpdated(cartItems));  // Update state with the modified cart
        await getUserCart();           // Refresh the entire cart after the update
        emit(updateCartSuccess());     // Emit success state
      } else {
        emit(updateCartError(response.data['message'] ?? "Failed to update cart item"));
      }
    } catch (error) {
      emit(updateCartError("An error occurred while updating the cart"));
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
          item.quantity = newQuantity;
          emit(CartUpdated(cartItems));  // Update state with modified cart
          await getUserCart();           // Refresh cart after update
          emit(updateCartSuccess());     // Emit success state
        } else {
          emit(updateCartError(response.data['message'] ?? "Failed to update cart item"));
        }
      } catch (error) {
        emit(updateCartError("An error occurred while updating the cart"));
      }
    }
  }
}