import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe/Consts/Consts.dart';

import 'package:shoppe/Widgets/Custom%20Button%20Widget.dart';

import 'home.dart';

class CongratulatoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              Icons.emoji_events, // Replace with your icon
              size: 64.0, // Icon size
              color: KPrimeryColor, // Icon color
            ),
            SizedBox(height: 20), // Space between icon and text
            // Congratulatory text
            Text(
              'Congrat!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Space between text and description
            Text(
              'Thank you for purchasing. Your order will be shipped in 2-4 working days.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40), // Space before button
            // Continue Shopping button
           CustomButton(ontap: (){
             Get.to( HomeScreen());
           }, width: 250, text: "Continue Shooping", height: 50, fontsize: 16)
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CongratulatoryScreen(),
  ));
}
