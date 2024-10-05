import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Make sure to import the necessary Bloc package.
import '../Widgets/textfieldsearch.dart';
import '../Widgets/bottomNavigationBar.dart';
import '../Widgets/productlistveiw.dart';
import '../cubit/search_cubit.dart';
import '../cubit/products_cubit.dart';

import 'package:get/get.dart';// تأكد من استيراد SearchCubit

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) { return BlocListener <ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is  ProductsError ) {
          Get.snackbar(
            "Error",
            state.message ?? "An error occurred", // Handle null message safely
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      child:
     BlocProvider(
      create: (context) => SearchCubit(), // إنشاء SearchCubit
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Products List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xff004CFF),
        ),
        body: Column(
          children: [
            Textfieldsearch(), // TextField للبحث
            Productlistveiw(),  // عرض المنتجات أو نتائج البحث
          ],
        ),
        bottomNavigationBar: Bottomnavigationbar(),
      ),
    ));
  }
}
