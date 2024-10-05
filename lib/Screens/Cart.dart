import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe/Consts/Consts.dart';
import 'package:shoppe/SCreens/categoriesview.dart';
import '../Helpers/dio_helper.dart';
import '../Models/CartModel.dart';
import '../Widgets/BuildItemCart.dart';
import '../Widgets/Custom Button Widget.dart';
import '../Widgets/Methods.dart';
import '../Widgets/bottomNavigationBar.dart';
import '../cubit/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DioHelper.inint(); // Initialize DioHelper

    return FutureBuilder(

      future: _initializeCart(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(color: Colors.white,child: const Center(child: CircularProgressIndicator(backgroundColor:Colors.white)));
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return _buildCartScreen(context);
        }
      },
    );
  }

  // Initialize the cart and wait for it
  Future<void> _initializeCart(BuildContext context) async {
    final cartCubit = context.read<CartCubit>();
    await cartCubit.getUserCart();
  }

  // Build the UI for the cart screen after cart data is loaded
  Widget _buildCartScreen(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartError) {
          Get.snackbar(
            "Error",
            state.message ?? "An error occurred",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildCartSuccessContent(cartCubit, context);
          },
        ),
      ),
    );
  }

  Widget _buildCartSuccessContent(CartCubit cartCubit, BuildContext context) {
    final cartProductsList = cartCubit.cartModel?.cartItems ?? [];


    return Column(
      children: [
        _buildCartHeader(cartProductsList, cartCubit, context),
        Expanded(
          child: cartProductsList.isEmpty
              ? _buildEmptyCartMessage()
              : _buildCartItemsList(cartProductsList),
        ),
        Bottomnavigationbar(),
      ],
    );
  }

  Widget _buildCartHeader(
      List<CartItem> cartProductsList, CartCubit cartCubit, BuildContext context) {
    return Container(
      color: Color(0xff004BFE),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
        ),
        child: Row(
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
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                Center(
                  child: Text(
                    cartProductsList.length.toString(),
                    style: const TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "\$${cartCubit.total ?? 0}", // Update this according to your total calculation
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Raleway",
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 2),
            InkWell(
              onTap: () {
                cartCubit.clearCart();
              },
              child: const Text(
                "Clear",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCartMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
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
          const Spacer(flex: 2),
          _buildCheckoutButton("Go Shopping"),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildCartItemsList(List<CartItem> cartProductsList) {
    return ListView.separated(
      itemCount: cartProductsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            right: MediaQuery.of(context).size.width * 0.02,
          ),
          child: BlocBuilder<CartCubit, CartState>(
  builder: (context, state) {
    if(state is CartItemRemovedLoading && state.id == cartProductsList[index].product.id){
      return(Center(child: CircularProgressIndicator(),));

    }
    return CartItemWidget(
            cartItem: cartProductsList[index],
            screenWidth: MediaQuery.of(context).size.width,
            screenHeight: MediaQuery.of(context).size.height,
          );
  },
),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 0);
      },
    );
  }

  Widget _buildCheckoutButton(String buttonText) {
    return Center(
      child: CustomButton(
        ontap: () {
          Get.to(CategoryView());
        },
        width: 170,
        text: buttonText,
        height: 50,
        fontsize: 16,
      ),
    );
  }

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
