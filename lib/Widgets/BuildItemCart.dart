import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/CartModel.dart';
import '../cubit/cart_cubit.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final double screenWidth;
  final double screenHeight;

  CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return Dismissible(
      key: Key(cartItem.product.id.toString()), // Unique key for each cart item
      direction: DismissDirection.endToStart, // Swipe from right to left
      onDismissed: (direction)async {
       await cubit.deleteCartItem(cartItem);

      },
      background: Container(
        color: Color(0xffEDEDED),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(
          Icons.delete,
          color: Color(0xff7B7B77),
          size: 30,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!.withOpacity(0.3),
                    spreadRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.25,
                    height: screenHeight * 0.10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        cartItem.product.image ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            cartItem.product.name ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "NutioSans",
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$${cartItem.product.price ?? 0}",
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
                                  InkWell(
                                    onTap: () {
                                      cubit.decreaseQuantity(cartItem);
                                      cubit.updateQuantity(
                                          cartItem, cartItem.quantity);
                                    },
                                    child: addRemoveFromCart(Icons.remove),
                                  ),
                                  const SizedBox(width: 5),
                                  BlocBuilder<CartCubit, CartState>(
                                    builder: (context, state) {
                                      return Center(
                                        child: Text(
                                          "${cartItem.quantity}",
                                          style: const TextStyle(
                                            fontFamily: "Raleway",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  InkWell(
                                    onTap: () async {
                                      cubit.increaseQuantity(cartItem);
                                      await cubit.updateQuantity(
                                          cartItem, cartItem.quantity);
                                    },
                                    child: addRemoveFromCart(Icons.add),
                                  ),
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
            );
          },
        ),
      ),
    );
  }

  Container addRemoveFromCart(IconData icn) {
    return Container(
      child: Icon(
        icn,
        color: Color(0xff7F7F7F),
        size: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Color(0xffE2E2E2),
          width: 2,
        ),
      ),
      width: 30,
      height: 30,
    );
  }
}
