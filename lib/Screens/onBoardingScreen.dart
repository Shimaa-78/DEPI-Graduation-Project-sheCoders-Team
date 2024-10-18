import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:shoppe/Screens/LoginScreen.dart';
import 'package:shoppe/Screens/profile_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Helpers/hive_helper.dart';
import '../Models/OnboardingModel.dart';

/////////
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  void initState() {
    HiveHelper.setValueInOnboardingBox();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image that takes the full screen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Bubbles.png"),
                fit: BoxFit.cover, // Ensures the image covers the full screen
              ),
            ),
          ),
          // Positioned child container with custom width, height, and decoration
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider(
                  items: List.generate(
                    OnboardingList.length,
                        (index) => Container(
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                "${OnboardingList[index].imagePath}",
                                fit: BoxFit.cover,
                              )),
                          SizedBox(height: 20,),
                          Text(
                            "${OnboardingList[index].title}",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Raleway"),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "${OnboardingList[index].Discreption}",
                            style: TextStyle(
                                fontFamily: "NunitoSans",
                                fontSize: 19,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      width: 306,
                      height: 600,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 236, 232, 232),
                            spreadRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    height: 600,
                    aspectRatio: 16 / 9,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });

                      // Check if the last screen is reached
                      if (currentIndex == OnboardingList.length - 1) {

                        Future.delayed(Duration(seconds: 3), () {
                          Get.offAll(LoginScreen());

                        });
                      }
                    },
                  ),
                ),

                SizedBox(height: 30),
                AnimatedSmoothIndicator(
                  activeIndex: currentIndex,
                  count: OnboardingList.length,
                  effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 20,
                    dotWidth: 20,
                    spacing: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
