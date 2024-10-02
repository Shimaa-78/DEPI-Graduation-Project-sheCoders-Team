import 'ProducModel.dart';

class CartModel {
  final List<CartItem> cartItems;

  CartModel({required this.cartItems,});

  factory CartModel.fromJson(Map<String, dynamic> json,) {
    var list = json['data']['cart_items'] as List;
    List<CartItem> cartItemsList = list.map((i) => CartItem.fromJson(i)).toList();
    return CartModel(cartItems: cartItemsList);
  }



}
class CartItem {
  final int id;
   int quantity;
  final Product product;

  CartItem({required this.id, required this.quantity, required this.product});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
    );
  }
}


