import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shoppe/SCreens/startScreen.dart';

import 'Helpers/DioHelper.dart';
import 'Screens/Cart.dart';
import 'helpers/dio_helper.dart';
import 'helpers/hive_helper.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.token);
  DioHelper.inint();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
        create: (context) => CartCubit(),),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,

        home:Scaffold(
          body: StartScreen(),
        ),
      ),
    );
  }
}

