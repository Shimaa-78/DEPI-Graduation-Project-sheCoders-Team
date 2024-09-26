import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/CartModel.dart';
import '../cubit/cart_cubit.dart'; // Adjust the import according to your project structure

class CartItemWidget extends StatelessWidget {
  final Product cartItem;
  final double screenWidth;
  final double screenHeight;
  final int quantity;

  const CartItemWidget({Key? key,
    required this.cartItem,
    required this.screenWidth,
    required this.screenHeight,
    required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        child: Row(
          children: [
            // Image and delete button (remains unchanged)
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: screenWidth * 0.35,
                  height: screenHeight * 0.15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      cartItem.image ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      cubit.addOrRemoveFromTheCart(cartItem.id.toString());
                    },
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
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name ?? "",
                    style:
                    const TextStyle(fontSize: 16, fontFamily: "NutioSans"),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${cartItem.price ?? 0}",
                        style: const TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Decrease Quantity Button
                            InkWell(
                              onTap: () {
                                if (quantity > 1) {
                                  cubit.updateCartItemQuantity(
                                      cartItem.id, quantity - 1);
                                }
                              },
                              child: add_remove_FromCart(Icons.remove),
                            ),
                            const SizedBox(width: 5),
                            // Display Current Quantity
                            BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                                return Container(
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
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(7)),
                                    color: const Color(0xffE5EBFC),
                                  ),
                                  width: screenWidth * 0.1,
                                  height: screenHeight * 0.05,
                                );
                              },
                            ),
                            const SizedBox(width: 5),
                            // Increase Quantity Button
                            InkWell(
                              onTap: () {
                                cubit.updateCartItemQuantity(
                                    cartItem.id, quantity + 1);
                              },
                              child: add_remove_FromCart(Icons.add),
                            ),
                          ],
                        ),
                      ), // Fallback for other states
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
        color: Colors.blue,
        size: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
      ),
      width: 30,
      height: 30,
    );
  }
}
