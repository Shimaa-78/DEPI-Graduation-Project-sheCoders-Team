import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shoppe/Screens/SignUp.dart';
import 'package:shoppe/Screens/startScreen.dart';
import 'package:shoppe/cubit/category_cubit.dart';
import 'package:shoppe/cubit/favourite_cubit.dart';
import 'package:shoppe/cubit/products_cubit.dart';
import 'package:shoppe/cubit/search_cubit.dart';
import 'Consts.dart';
import 'Cubit/login_cubit.dart';
import 'Screens/Cart.dart';
import 'Screens/shippingscreen.dart';
import 'firebase_options.dart';
import 'Cubit/profile_cubit.dart';
import 'cubit/cart_cubit.dart';
import 'helpers/dio_helper.dart';
import 'helpers/hive_helper.dart';

import 'Screens/home.dart';
import 'language_cubit/language_cubit.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox(HiveHelper.token);
  await Hive.openBox('USER_BOX');
  await Hive.openBox(HiveHelper.userPhoneNumber);
  await Hive.openBox(HiveHelper.onboardingBox);
  await Hive.openBox(HiveHelper.KEY_BOX_APP_LANGUAGE);
  DioHelper.inint();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
          create: (context) => CartCubit()..getUserCart(),
        ),
        BlocProvider(
          create: (context) => FavouriteCubit()..getFavouriteList(),

        ),
        BlocProvider(
          create: (context) => LanguageCubit(),

        ),

        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit()..fetchCategories(),

        ),
        BlocProvider(
          create: (context) => SearchCubit(),

        ),
      ],
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return GetMaterialApp(
              locale: state.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: StartScreen(),
              ),
            );
          },
        ),
    );
  }
}
