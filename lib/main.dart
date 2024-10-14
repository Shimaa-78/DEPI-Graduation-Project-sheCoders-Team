import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Correct import for Hive Flutter initialization
import 'package:shoppe/SCreens/categoriesview.dart';
import 'package:shoppe/Screens/LoginScreen.dart';
import 'package:shoppe/Screens/startScreen.dart'; // Adjust casing to match actual file names
import 'package:shoppe/cubit/favourite_cubit.dart';

import 'Cubit/login_cubit.dart';
import 'Screens/home.dart';
import 'cubit/category_cubit.dart';
import 'cubit/products_cubit.dart';

import 'Screens/Cart.dart';
import 'Screens/favorite.dart';
import 'cubit/cart_cubit.dart';
import 'helpers/dio_helper.dart';
import 'helpers/hive_helper.dart'; // Check casing for the imports

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Moved to the right position
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.token);
  DioHelper.inint();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit()..fetchCategories(),
        ),

        BlocProvider<ProductsCubit>(
          create: (context) =>ProductsCubit()..fetchProducts(85),
        
        ),


        // BlocProvider(
        //   create: (context) => LoginCubit(),
        // ),
        // BlocProvider(
        //   create: (context) => CartCubit()..getUserCart(),
        // ),
        // BlocProvider(
        //   create: (context) => FavouriteCubit()..getFavouriteList(),
        //
        // ),
      ],

       child:  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body:   HomeScreen(),
        ),

    ),
    );
  }
}