import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shoppe/Models/CartModel.dart';
import 'package:shoppe/Screens/Cart.dart';

import '../Models/ProducModel.dart';
import '../cubit/cart_cubit.dart';

class Buttonaddcart extends StatelessWidget {

  Color buttonColor = Color(0xff004CFF);
  Product product;

  Buttonaddcart({required this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return ElevatedButton(
      onPressed: () {
        cubit.addToCart(product.id.toString());
      },
      child: BlocBuilder<CartCubit, CartState>(

        builder: (context, state) {
          if(state is addTocartLoading){
            return Text(
              cubit.cartIds.contains(product.id.toString()) ?"Removing From cart .."
              :"Adding to Cart ..." ,
              style: TextStyle(fontSize: 20, color: Colors.white),
            );
          }
          return Text(
            cubit.cartIds.contains(product.id.toString()) ?
            "Remove From Cart" : "Add to Cart",
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