import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe/Consts/Consts.dart';
import 'package:shoppe/Widgets/Custom Button Widget.dart'; // Fix import
import '../Helpers/DioHelper.dart';
import '../Models/CartModel.dart';
import '../Widgets/BuildItemCart.dart';
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
            top: MediaQuery.of(context).size.height *
                0.05, // Responsive vertical padding
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width *
                0.05, // Responsive horizontal padding
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
                          final cartProductsList =
                              cubit.cartModel?.cartItems ?? [];
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
                    String buttonString =
                        cartProductsList.isEmpty ? "Go Shopping" : "Check out";

                    return Expanded(
                      child: cartProductsList.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleLogo(
                                      "assets/images/Logo_for_emty_Cart.png"),
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
                                return CartItemWidget(



                                  cartItem: cartProductsList[index].product,
                                  screenWidth:  MediaQuery.of(context).size.width,
                                  screenHeight: MediaQuery.of(context).size.height,
                                  quantity:           cartProductsList[index].quantity,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
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
                        "Total \$${cubit.total ?? 0}", // Update this according to your total calculation
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Raleway",
                        ),
                      ),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          final cartProductsList =
                              cubit.cartModel?.cartItems ?? [];
                          return CustomButton(
                            ontap: () {}, // Define the onTap function
                            width: 170,
                            text: state is CartSuccess
                                ? (cartProductsList.isEmpty
                                    ? "Go Shopping"
                                    : "Check out")
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
