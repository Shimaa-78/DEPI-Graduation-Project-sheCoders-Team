import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/category_cubit.dart';
import 'package:get/get.dart';

import '../Widgets/categorylistview.dart';
import '../Widgets/bottomNavigationBar.dart'; // تأكد من استيراد الـ Bottom Navigation Bar

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryError ) {
          Get.snackbar(
            "Error",
            state.message ?? "An error occurred", // Handle null message safely
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(

      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff004CFF),
      ),
      body: BlocProvider(
        create: (context) {
          final cubit = CategoryCubit();
          cubit.fetchCategories(); // استدعاء fetchCategories هنا
          return cubit;
        },
        child: Categorylistview(), // عرض قائمة الفئات
      ),
      bottomNavigationBar: Bottomnavigationbar(), // يجب أن تكون هنا
    ));
  }
}
/////////////////////