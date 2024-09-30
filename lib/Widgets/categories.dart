import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/categorymodel.dart';
import '../cubit/products_cubit.dart'; // Make sure to import the correct cubit
import '../Screens/productlist.dart';// Import the screen for navigation

class CategoryWidget extends StatelessWidget {
  final CategoryModel categoryModel;

  CategoryWidget({required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // لف شاشة ProductListScreen بـ BlocProvider لـ ProductsCubit
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) {
                final cubit =  ProductsCubit (); // إنشاء CategoryCubit
                cubit.fetchProducts (categoryModel.id); // استدعاء fetchCategories هنا
                return cubit; // إرجاع الـ cubit
              },
              child: ProductListScreen(), // الشاشة التي يتم التنقل إليها
            ),
          ),
        );
      },

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                categoryModel.name,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                categoryModel.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
