import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/categorymodel.dart';
import '../cubit/products_cubit.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel categoryModel;

  CategoryWidget({required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // استدعاء جلب المنتجات للفئة المختارة
        context.read<ProductsCubit>().fetchProducts(categoryModel.id);
      },
      child: Container(
        height: 200,
        width: 200,
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
              child: Container(
                height: 90, // Set fixed height for the image
                width: MediaQuery.of(context).size.width * 0.9, // Responsive width
                child: Image.network(
                  categoryModel.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error); // Handle image loading errors
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

