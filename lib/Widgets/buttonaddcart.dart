import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shoppe/Models/CartModel.dart';
import 'package:shoppe/Screens/Cart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Helpers/dio_helper.dart';
import '../Models/ProducModel.dart';
import '../cubit/cart_cubit.dart';

class Buttonaddcart extends StatelessWidget {

  Color buttonColor = Color(0xff004CFF);
  Product product;

  Buttonaddcart({required this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    DioHelper.inint();
    cubit.getUserCart();
    return ElevatedButton(
      onPressed: () {
        cubit.addToCart(product.id.toString());
      },
      child: BlocBuilder<CartCubit, CartState>(

        builder: (context, state) {
          if(state is addTocartLoading){
            return Text(
              cubit.cartIds.contains(product.id.toString()) ? AppLocalizations.of(context)!.removing_from_cart
              : AppLocalizations.of(context)!.adding_to_cart,
              style: TextStyle(fontSize: 20, color: Colors.white),
            );
          }
          return Text(
            cubit.cartIds.contains(product.id.toString()) ?
            AppLocalizations.of(context)!.remove_from_cart : AppLocalizations.of(context)!.add_to_cart,
            style: TextStyle(fontSize: 20, color: Colors.white),
          );
        },
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 50), // عرض وارتفاع الزر
        backgroundColor: buttonColor, // لون الزر
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // تقليل نصف القطر هنا
        ),
      ),
    );
  }
}