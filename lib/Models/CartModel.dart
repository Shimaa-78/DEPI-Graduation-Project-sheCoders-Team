class CartModel {
  final List<CartItem> cartItems;
  final double total; // New property for total

  CartModel({required this.cartItems, required this.total}); // Include total in constructor

  factory CartModel.fromJson(Map<String, dynamic> json) {
    var list = json['data']['cart_items'] as List;
    List<CartItem> cartItemsList = list.map((i) => CartItem.fromJson(i)).toList();

    // Ensure this line correctly accesses the total
    double total = json['data']['total'] != null ? json['data']['total'].toDouble() : 0.0;

    return CartModel(
      cartItems: cartItemsList,
      total: total,
    );
  }

}


class CartItem {
  final int id;
  final int quantity;
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
