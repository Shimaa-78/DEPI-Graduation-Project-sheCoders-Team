import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/ProducModel.dart';
import '../cubit/cart_cubit.dart'; // Adjust the import according to your project structure

class CartItemWidget extends StatelessWidget {
  final Product cartItem;
  final double screenWidth;
  final double screenHeight;
  final int quantity;


  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.screenWidth,
    required this.screenHeight,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: screenWidth * 0.35, // Make responsive
                  height: screenHeight * 0.15, // Make responsive
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      cartItem.image ?? "", // Handle null image URL safely
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error), // Fallback for broken image
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap:(){
                      cubit.addOrRemoveFromTheCart(cartItem.id.toString());
                    } ,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.delete_outline_outlined,
                        color: const Color(0xffD97474),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: screenWidth * 0.03), // Responsive spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name ?? "", // Handle null description safely
                    style: const TextStyle(fontSize: 16, fontFamily: "NutioSans"),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
                    children: [
                      Text(
                        "\$${cartItem.price ?? 0}", // Handle null price safely
                        style: const TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end, // Keep the row for quantity controls
                          children: [
                            add_remove_FromCart(Icons.remove),
                            const SizedBox(width: 5),
                            Container(
                              child: Center(
                                child: Text(
                                  "$quantity",
                                  style: const TextStyle(
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(7)),
                                color: const Color(0xffE5EBFC),
                              ),
                              width: screenWidth * 0.1, // Responsive width
                              height: screenHeight * 0.05, // Responsive height
                            ),
                            const SizedBox(width: 5),
                            add_remove_FromCart(Icons.add),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container add_remove_FromCart(IconData icn) {
    return Container(
      child: Icon(
        icn,
        color: Colors.blue, // Use your primary color constant if available
        size: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.blue, // Use your primary color constant if available
          width: 2,
        ),
      ),
      width: 30,
      height: 30,
    );
  }
}
