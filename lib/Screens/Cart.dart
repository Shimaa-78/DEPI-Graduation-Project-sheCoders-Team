import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe/Consts/Consts.dart';
import 'package:shoppe/Widgets/Custom Button Widget.dart'; // Fix import
import '../Helpers/DioHelper.dart';
import '../Models/CartModel.dart';
import '../Widgets/Methods.dart';
import '../cubit/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    DioHelper.inint();
    cubit.getUserCart();

    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartError) {
          Get.snackbar(
            "Error",
            state.message ?? "An error occurred", // Handle null message safely
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05, // Responsive vertical padding
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05, // Responsive horizontal padding
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Cart",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(width: 3),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xffE5EBFC),
                    child: Center(
                      child: BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          final cartProductsList = cubit.cartModel?.cartItems ?? [];
                          return Text(
                            cartProductsList.length.toString(),
                            style: const TextStyle(
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // BlocBuilder to handle state changes
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CartSuccess) {
                    final cartProductsList = cubit.cartModel?.cartItems ?? [];
                    String buttonString = cartProductsList.isEmpty ? "Go Shopping" : "Check out";

                    return Expanded(
                      child: cartProductsList.isEmpty
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleLogo("assets/images/Logo_for_emty_Cart.png"),
                            const SizedBox(height: 20),
                            const Text(
                              "Your cart is empty!",
                              style: TextStyle(
                                color: Color(0xff004BFE),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Raleway",
                              ),
                            ),
                          ],
                        ),
                      )
                          : ListView.separated(
                        itemCount: cartProductsList.length,
                        itemBuilder: (context, index) {
                          return buildCartItem(
                            context,
                            cartProductsList[index].product,
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height,
                            cartProductsList[index].quantity,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 10);
                        },
                      ),
                    );
                  } else if (state is CartError) {
                    return Center(
                      child: Text(
                        "Failed to load cart items: ${state.message}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return Container(); // Default case
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total \$${cubit.cartModel?.total ?? 0.0}", // Update this according to your total calculation
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Raleway",
                        ),
                      ),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          final cartProductsList = cubit.cartModel?.cartItems ?? [];
                          return CustomButton(
                            ontap: () {}, // Define the onTap function
                            width: 170,
                            text: state is CartSuccess
                                ? (cartProductsList.isEmpty ? "Go Shopping" : "Check out")
                                : "",
                            height: 50,
                            fontsize: 16,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build each Cart Item
  Widget buildCartItem(BuildContext context, Product cartItem,
      double screenWidth, double screenHeight, int quantity) {
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
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.delete_outline_outlined,
                      color: const Color(0xffD97474),
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
        color: KPrimeryColor,
        size: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: KPrimeryColor,
          width: 2,
        ),
      ),
      width: 30,
      height: 30,
    );
  }
}
