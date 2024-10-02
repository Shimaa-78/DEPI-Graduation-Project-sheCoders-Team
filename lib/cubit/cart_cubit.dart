import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import '../Helpers/dio_helper.dart';
import '../Models/CartModel.dart';
import 'package:shoppe/Consts/KApis.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartModel? cartModel;
   List<CartItem> cartItems = [];
  CartCubit() : super(CartInitial());
  double? total;
  Set<String> cartIds = {};
  Future<void> getUserCart() async {
    emit(CartLoading());
    try {
      final response = await DioHelper.getData(path: KApis.cartPath);
      print("API Response: ${response.data}");

      if (response.data['status']) {
        cartModel = CartModel.fromJson(response.data);


        for (var item in cartModel!.cartItems) {
          cartIds.add(item.product.id.toString());
        }

        total = response.data['data']['total'].toDouble();
        emit(CartSuccess());
      } else {
        emit(CartError("Failed to load cart items"));
      }
    } catch (error) {
      print(error.toString());
      emit(CartError("An error occurred Check Your Internet Connection"));
    }

  }
  Future<void> deleteCartItem(CartItem cartItem) async {
    emit(CartItemRemovedLoading(cartItem.product.id));
    try {
      final response = await DioHelper.deleteData(
        path: '${KApis.cartPath}/${cartItem.id}',
      );
      if (response.data['status']) {
        cartModel?.cartItems.remove(cartItem);
        cartIds.remove(cartItem.product.id.toString());
        calculateTotal();
        emit(CartItemRemoved(cartModel!.cartItems));
      } else {
        emit(CartItemRemovedError("Failed to delete cart item"));
      }
    } catch (error) {
      emit(CartItemRemovedError("An error occurred while deleting the cart item"));
    }
  }
  void addToCart(String productId) async {
    // Change type to int
    emit(addTocartLoading());
    try {
      final response = await DioHelper.postData(path: KApis.cartPath, body: {
        'product_id': productId.toString(),
      });
      print("API Response: ${response.data}");

      if (response.data['status']) {

        if (cartIds.contains(productId)) {

          cartIds.remove(productId);
        } else {
          cartIds.add(productId.toString());
        }
         await getUserCart();

        emit(addTocartSuccess());
      } else {
        // Refresh cart if the operation fails
        emit(addTocartCartError("Failed to load cart items"));
      }
    } catch (error) {
      print(error.toString());
      emit(addTocartCartError("An error occurred Check Your Internet Connection"));
    }
  }
  void calculateTotal() {
    total =0;
    for (var item in cartModel?.cartItems ?? []) {

      total = (total! + (item.product.price * item.quantity.toDouble()));

    }

    emit(CartTotalUpdated(total!));

  }


  void increaseQuantity(CartItem item) {
     item.quantity+=1;
     calculateTotal();
    emit(QuantityUpdated(item));

  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity-=1;
      calculateTotal();
      emit(QuantityUpdated(item));
    } else {

      deleteCartItem(item);
    }
  }

  Future<void> updateQuantity(CartItem item,newQuantity) async {


    emit(updateCartLoading());
    try {
      final response = await DioHelper.putData(
        path: '${KApis.cartPath}/${item.id}',
        body: {'quantity': newQuantity},
      );
      if (response.data['status']) {

          // await getUserCart();
        print("+====================================================${item.id}");

        emit(updateCartSuccess());
      } else {
        emit(updateCartError(response.data['message'] ?? "Failed to update cart item"));
      }
    } catch (error) {
      emit(updateCartError("An error occurred Check Your Internet Connection"));
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