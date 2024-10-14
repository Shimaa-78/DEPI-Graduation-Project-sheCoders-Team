import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';
import 'productcard.dart';

class Productlistveiw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductsLoaded) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return Productcard(product: state.products[index]);
            },
          );
        } else if (state is ProductsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Container(); // Return an empty container if no state is met
        }
      },
    );
  }
}
