import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Make sure to import the necessary Bloc package.
import '../Widgets/textfieldsearch.dart';
import '../Widgets/bottomNavigationBar.dart';
import '../Widgets/productlistveiw.dart';
import '../cubit/search_cubit.dart';
import '../Widgets/productsearchlistveiw.dart';
// تأكد من استيراد SearchCubit
import 'package:get/get.dart';
class ProductsearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
              // TextField للبحث
            Productsearchlistveiw()  // عرض المنتجات أو نتائج البحث
          ],
        ),
        bottomNavigationBar: Bottomnavigationbar(),
      );

  }
}
/////////////////////