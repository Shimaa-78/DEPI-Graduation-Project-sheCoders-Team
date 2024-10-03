import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
 import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Correct import for Hive Flutter initialization
import 'package:shoppe/Screens/LoginScreen.dart';
import 'package:shoppe/Screens/startScreen.dart'; // Adjust casing to match actual file names

import 'Cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import for MultiBlocProvider
import 'package:get/get_navigation/src/root/get_material_app.dart'; // Import for GetX
import 'package:shoppe/Screens/startScreen.dart'; // Your StartScreen widget
import 'package:shoppe/Screens/Cart.dart'; // Assuming you have this screen
 // Assuming your cubit is here

import 'Screens/Cart.dart';
import 'Screens/SignUp.dart';
import 'cubit/cart_cubit.dart';
import 'helpers/dio_helper.dart';
import 'helpers/hive_helper.dart'; // Check casing for the imports
import 'Cubit/personal_details_cubit.dart';
import 'Cubit/profile_cubit.dart'; // Assuming your cubit is here

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  // Open necessary Hive boxes
  await Hive.openBox(HiveHelper.token);
  await Hive.openBox('USER_BOX');
  await Hive.openBox(HiveHelper.userPhoneNumber);


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => PersonalDetailsCubit(),
        ),

      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body:StartScreen(),
        ),
      ),
    );
  }
}

