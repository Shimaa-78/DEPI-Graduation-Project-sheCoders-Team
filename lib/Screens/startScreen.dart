import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe/Consts/Kcolors.dart';
import 'package:shoppe/SCreens/categoriesview.dart';
import 'package:shoppe/Screens/LoginScreen.dart';
import 'package:shoppe/Screens/onBoardingScreen.dart';
import 'package:shoppe/Widgets/Custom%20Button%20Widget.dart';

import '../Helpers/hive_helper.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 254, 254),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 4,
            ),
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 236, 232, 232),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Image.asset(
                "assets/images/Logo.png",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Shoppe",
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 52,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "Beautiful eCommerce UI Kit for your online store",
              style: TextStyle(
                  fontFamily: "NunitoSans",
                  fontSize: 19,
                  // color: Colors.grey,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 2,
            ),
            CustomButton(
              fontsize: 22,
              height: 60,
              text: "Let's get started",
              width: 400,
              ontap: () {

                if (HiveHelper.checkOnBoardingValue()) {
                  print("======================Start Token ${HiveHelper.checkOnBoardingValue()}");
                  if (HiveHelper.getToken() != null) {
                    Get.offAll(CategoryView());
                  } else {
                    Get.offAll(LoginScreen());
                  }
                } else {
                  Get.offAll(OnBoardingScreen());
                }
              },
            ),
            SizedBox(
              height: 20,
            ),

            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
