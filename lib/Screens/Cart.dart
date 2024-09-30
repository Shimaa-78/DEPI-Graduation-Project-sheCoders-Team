import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe/Consts/Consts.dart';
import '../Helpers/dio_helper.dart';
import '../Models/CartModel.dart';
import '../Widgets/BuildItemCart.dart';
import '../Widgets/Custom Button Widget.dart';
import '../Widgets/Methods.dart';
import '../cubit/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    DioHelper.inint();
    cartCubit.getUserCart();

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
            top: MediaQuery.of(context).size.height * 0.04,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(child: CircularProgressIndicator(

                ));
              }
                return _buildCartSuccessContent(cartCubit);

              // Handle other states if necessary
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCartSuccessContent(CartCubit cartCubit) {
    final cartProductsList = cartCubit.cartModel?.cartItems ?? [];
    String buttonText = cartProductsList.isEmpty ? "Go Shopping" : "Check out";

    return Column(
      children: [
        _buildCartHeader(cartProductsList,cartCubit),
        Expanded(
          child: cartProductsList.isEmpty
              ? _buildEmptyCartMessage()
              : _buildCartItemsList(cartProductsList),
        ),
        _buildTotalAndCheckoutButton(cartCubit, buttonText),
      ],
    );
  }

  Widget _buildCartHeader(List<CartItem> cartProductsList,CartCubit cartCubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                child: Text(
                  cartProductsList.length.toString(),
                  style: const TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],

        ),
        InkWell(
          onTap: (){
            cartCubit .clearCart();
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xffE5EBFC),
            child: Text(
              "Clear",
              style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCartMessage() {
    return Center(
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
    );
  }

  Widget _buildCartItemsList(List<CartItem> cartProductsList) {
    return ListView.separated(
      itemCount: cartProductsList.length,
      itemBuilder: (context, index) {
        return CartItemWidget(
          cartItem: cartProductsList[index],
          screenWidth: MediaQuery.of(context).size.width,
          screenHeight: MediaQuery.of(context).size.height,
           quantity: cartProductsList[index].quantity,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 0);
      },
    );
  }

  Widget _buildTotalAndCheckoutButton(CartCubit cartCubit, String buttonText) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total \$${cartCubit.total ?? 0}", // Update this according to your total calculation
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Raleway",
              ),
            ),
            CustomButton(
              ontap: () {
                // Define the onTap function
              },
              width: 170,
              text: buttonText,
              height: 50,
              fontsize: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Method to build each Cart Item
  Container addRemoveFromCart(IconData iconData) {
    return Container(
      child: Icon(
        iconData,
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