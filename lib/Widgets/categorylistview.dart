import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/categorymodel.dart';
import '../cubit/category_cubit.dart';
import 'categories.dart';

class Categorylistview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch categories before returning the BlocBuilder


    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoaded) {
          return ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              return CategoryWidget(categoryModel: state.categories[index]);
            },
          );
        } else if (state is CategoryError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Container(); // Return an empty widget (or something else) in other cases
        }
      },
    );
  }
}

