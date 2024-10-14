import 'package:flutter/material.dart';
import '../Models/categorymodel.dart';
import '../Widgets/categories.dart';

class CategoryListView extends StatelessWidget {
  final List<CategoryModel> categories;

  CategoryListView({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // ارتفاع القائمة
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // عرض القائمة بشكل أفقي
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryWidget(categoryModel: categories[index]);
        },
      ),
    );
  }
}
