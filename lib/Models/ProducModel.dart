class Product {
  final int id;
  final double price;
  final double? oldPrice; // Optional
  final int? discount;    // Optional
  final String image;
  final String name;
  final String description;

  Product({
    required this.id,
    required this.price,
    this.oldPrice,         // Optional
    this.discount,         // Optional
    required this.image,
    required this.name,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'].toDouble(),
      oldPrice: json['old_price'] != null ? json['old_price'].toDouble() : null,  // Handle null for oldPrice
      discount: json['discount'] != null ? json['discount'] as int : null,        // Handle null for discount
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
