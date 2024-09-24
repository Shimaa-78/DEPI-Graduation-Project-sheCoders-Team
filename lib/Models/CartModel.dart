class CartModel {
  String image;
  String discreption;
  String color;
  String size;
  double price;
  int numofItems;

  CartModel({
    required this.image,
    required this.color,
    required this.size,
    required this.price,
    required this.discreption,
    required this.numofItems,
  });

  static double calculateTotal() {
    double total = 0.0;
    for (var item in CartList) {
      total += item.price * item.numofItems; // Removed type cast
    }
    return total;
  }
}

List<CartModel> CartList = [
  // CartModel(
  //   image: "assets/images/cart.jpg",
  //   discreption: "Lorem ipsum dolor sit amet consectetur.",
  //   color: "Pink",
  //   size: "large",
  //   price: 17.00,
  //   numofItems: 2,
  // ),

];
