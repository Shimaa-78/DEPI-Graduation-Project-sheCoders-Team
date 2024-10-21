import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe/Consts/Consts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../language_cubit/language_cubit.dart';
import 'package:shoppe/Screens/shippingscreen.dart';
import '../Helpers/dio_helper.dart';
import '../Models/CartModel.dart';
import '../Widgets/BuildItemCart.dart';
import '../Widgets/Custom Button Widget.dart';
import '../Widgets/Methods.dart';
import '../cubit/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DioHelper.inint(); // Initialize DioHelper

    return FutureBuilder(
      future: _initializeCart(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              color: Colors.white,
              child: const Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.white)));
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
            AppLocalizations.of(context)!.error,
            state.message ?? AppLocalizations.of(context)!.an_error_occurred,
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
    String buttonText = cartProductsList.isEmpty ? AppLocalizations.of(context)!.go_shopping
        : AppLocalizations.of(context)!.check_out;
    return Column(
      children: [
        _buildCartHeader(cartProductsList, cartCubit, context ),
        Expanded(
          child: cartProductsList.isEmpty
              ? _buildEmptyCartMessage(cartCubit,context)
              : _buildCartItemsList(cartProductsList),
        ),
        _buildTotalAndCheckoutButton(cartCubit,buttonText,context),
      ],
    );
  }

  Widget _buildCartHeader(List<CartItem> cartProductsList, CartCubit cartCubit,
      BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                cartCubit.clearCart();
              },
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.cart
                  ,style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black,
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
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            // Text(
            //   "\$${cartCubit.total ?? 0}", // Update this according to your total calculation
            //   style: const TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //     fontFamily: "Raleway",
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCartMessage(CartCubit cubit, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          CircleLogo("assets/images/Logo_for_emty_Cart.png"),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.your_cart_is_empty,
            style: const TextStyle(
              color: Color(0xff004BFE),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Raleway",
            ),
          ),
          const Spacer(flex: 2),

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
              if (state is CartItemRemovedLoading &&
                  state.id == cartProductsList[index].product.id) {
                return Container();
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

  Widget _buildTotalAndCheckoutButton(CartCubit cartCubit, String buttonText, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              AppLocalizations.of(context)!.total + " \$${cartCubit.total?.toStringAsFixed(1) ?? "0.0"}", // Format total to 1 decimal place
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Raleway",
                color: Color(0xffA6A6A6),
              ),
            ),

            CustomButton(
              ontap: () {
                if (cartCubit.cartModel?.cartItems.isEmpty ?? true) {
                  Get.to(HomeScreen()); // No ambiguity now
                } else {
                  Get.to(ShippingScreen("${cartCubit.total?.toStringAsFixed(1)}"));
                }
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