// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:shoppe/SCreens/startScreen.dart';
// import 'package:shoppe/cubit/cart_cubit.dart';
//
// import 'Helpers/DioHelper.dart';
// import 'Screens/Cart.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CartCubit(),
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//
//         home: Scaffold(
//           body: cartScreen(),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shoppe/SCreens/startScreen.dart';
import 'package:shoppe/Screens/LoginScreen.dart';
import 'package:shoppe/cubit/cart_cubit.dart';

import 'Helpers/DioHelper.dart';
import 'Screens/Cart.dart';

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
          body: LoginScreen(),
        ),
      ),
    );
  }
}

