import 'package:bloc/bloc.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:meta/meta.dart';
import 'package:shoppe/Consts/Kpis.dart';

import '../Helpers/DioHelper.dart';
import '../Models/CartModel.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartModel? cartModel;
  int? total;
  Set<String> cartIds = {};

  CartCubit() : super(CartInitial());

  Future<void> getUserCart() async {
    emit(CartLoading());
    try {
      final response = await DioHelper.getData(path: KApis.cartPath);
      print("API Response: ${response.data}");

      if (response.data['status']) {
        cartModel = CartModel.fromJson(response.data);

        // Use null-safe access and ensure cartItems is not null
        cartIds.clear();
        cartModel?.cartItems?.forEach((item) {
          cartIds.add(item.product.id.toString());
        });

        total = response.data['data']['total']?.toInt();
        emit(CartSuccess());
      } else {
        emit(CartError("Failed to load cart items"));
      }
    } catch (error) {
      print(error.toString());
      emit(CartError("An error occurred. Please check your connection."));
    }
  }

  Future<void> addOrRemoveFromTheCart(String productId) async {
    emit(adOrRemoveCartLoading());
    try {
      final response = await DioHelper.postData(
        path: KApis.cartPath,
        body: {'product_id': productId},
      );
      print("API Response: ${response.data}");

      if (response.data['status']) {
        // Toggle product ID in cart
        if (cartIds.contains(productId)) {
          cartIds.remove(productId);
        } else {
          cartIds.add(productId);
        }
        await getUserCart();
        emit(adOrRemoveCartSuccess());
      } else {
        emit(adOrRemoveCartError("Failed to update the cart"));
      }
    } catch (error) {
      print(error.toString());
      emit(adOrRemoveCartError("An error occurred while updating the cart"));
    }
  }

  Future<void> updateCartItemQuantity(int cartId, int newQuantity) async {
    emit(updateCartLoading());
    try {
      final response = await DioHelper.putData(
        path: '${KApis.cartPath}/$cartId',
        body: {'quantity': newQuantity},
      );
      print("API Response: ${response.data}");

      if (response.data['status']) {
        await getUserCart();
        emit(updateCartSuccess());
      } else {
        emit(updateCartError(response.data['message'] ?? "Failed to update cart item"));
      }
    } catch (error) {
      print(error.toString());
      emit(updateCartError("An error occurred while updating the cart"));
    }
  }

}
