import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import for MultiBlocProvider
import 'package:get/get_navigation/src/root/get_material_app.dart'; // Import for GetX
import 'package:shoppe/Screens/startScreen.dart'; // Your StartScreen widget
import 'package:shoppe/Screens/Cart.dart'; // Assuming you have this screen
 // Assuming your cubit is here

import 'Cubit/personal_details_cubit.dart';
import 'Cubit/profile_cubit.dart'; // Assuming your cubit is here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => PersonalDetailsCubit(),
        ),
      ],
      child: GetMaterialApp( // Using GetMaterialApp within MultiBlocProvider
        debugShowCheckedModeBanner: false,
        title: 'My App',
        home: Scaffold(
          body: StartScreen(), // Set your StartScreen as the initial screen
        ),
      ),
    );
  }
}


