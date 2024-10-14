import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/category_cubit.dart';
import '../cubit/products_cubit.dart';
import '../Models/categorymodel.dart';
import '../Widgets/categorylistview.dart';
import '../Widgets/listveiw.dart'; // Ensure this imports the correct ProductListView widget
import '../Widgets/textfieldsearch.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products with ID 80 when the page loads
    context.read<ProductsCubit>().fetchProducts(44);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5), // Add padding for top spacing
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Textfieldsearch(),
              // BlocBuilder for categories
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CategoryLoaded) {
                    return CategoryListView(categories: state.categories);
                  } else if (state is CategoryError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return Container();
                  }
                },
              ),
              // Reducing space between the two ListViews
              // BlocBuilder for products
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProductsLoaded) {
                    return   ProductListView(products: state.products);

                  } else if (state is ProductsError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return Center(child: Text('Select a category to view products'));
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
