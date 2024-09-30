import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shoppe/SCreens/startScreen.dart';
import 'package:shoppe/cubit/cart_cubit.dart';
import 'package:shoppe/SCreens/categoriesview.dart';
import 'package:shoppe/SCreens/productlist.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Correct import for Hive Flutter initialization
import 'package:shoppe/Screens/startScreen.dart'; // Adjust casing to match actual file names
import 'Screens/Cart.dart';
import 'Cubit/login_cubit.dart';

import 'cubit/cart_cubit.dart';
import 'helpers/dio_helper.dart';
import 'helpers/hive_helper.dart'; // Check casing for the imports

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: CartScreen(),
        ),
      ),
    );
  }
}
