class CartModel {
  final List<CartItem> cartItems;

  CartModel({required this.cartItems,});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    var list = json['data']['cart_items'] as List;
    List<CartItem> cartItemsList = list.map((i) => CartItem.fromJson(i)).toList();
    return CartModel(cartItems: cartItemsList);
  }



}
class CartItem {
  final int id;
  late final int quantity;
  final Product product;

  CartItem({required this.id, required this.quantity, required this.product});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
    );
  }
  get Id => id;
}
class Product {
  final int id;
  final double price;
  final double oldPrice;
  final int discount;
  final String image;
  final String name;
  final String description;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'].toDouble(),
      oldPrice: json['old_price'].toDouble(),
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
