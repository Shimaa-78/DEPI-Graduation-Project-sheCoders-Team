part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}
final class CartSuccess extends CartState {}
final class CartError extends CartState {
  String? message;
  CartError( this.message);
}


final class addTocartLoading extends CartState {}
final class addTocartSuccess extends CartState {}
final class addTocartCartError extends CartState {
  String? message;
  addTocartCartError( this.message);
}


final class updateCartLoading extends CartState {}
final class updateCartSuccess extends CartState {}
final class updateCartError extends CartState {
  String? message;
  updateCartError( this.message);
}


class QuantityUpdated extends CartState {
  final CartItem cartItem;

  QuantityUpdated(this.cartItem);
}


class CartItemRemovedLoading extends CartState {
  int? id;
  CartItemRemovedLoading(this.id);

}
class CartItemRemovedError extends CartState {
  String? message;
  CartItemRemovedError(this.message);
}
class CartItemRemoved extends CartState {
  final List<CartItem> cartItems;

  CartItemRemoved(this.cartItems);
}
class CartTotalUpdated extends CartState {
  final double total;

  CartTotalUpdated(this.total);
}

