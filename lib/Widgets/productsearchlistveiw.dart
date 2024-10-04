import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // تأكد من استيراد bloc
import 'package:dio/dio.dart';
import '../cubit/search_cubit.dart'; // استيراد SearchCubit بدلاً من ProductsCubit
import 'productcard.dart';
// تأكد من استيراد Dio

class Productsearchlistveiw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SearchSucess) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.products.length, // عدد المنتجات
                itemBuilder: (context, index) {
                  return   Productcard(product: state.products[index]); // استدعاء ProductCard
                },
              );
            } else if (state is SearchError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Container(); // Return an empty container for other states
            }
          },
        ),
      ),
    );
  }
}

