import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe/Screens/favorite.dart';

import '../Screens/Cart.dart';
import '../Screens/home.dart';
import '../Screens/profile_screen.dart';

class  Bottomnavigationbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
       BottomNavigationBar(

        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(onTap: (){
              Get.to(HomeScreen());
            },child: Icon(Icons.home)),
            label: '',
          ),/////////////////////
          BottomNavigationBarItem(
            icon: InkWell(child: Icon(Icons.favorite),onTap: (){
              Get.to(FavouriteScreen());
            },),
            label: 'Favorites',
          ),

          BottomNavigationBarItem(

            icon: InkWell(child: Icon(Icons.shopping_cart),onTap: (){

              Get.to(CartScreen());
            },),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: InkWell(child: Icon(Icons.person),onTap: (){
              Get.to(ProfilePage());
            },),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        backgroundColor: Colors.blue,
        selectedItemColor: Color(0xff004CFF),
        unselectedItemColor: Color(0xff004CFF),

    );
  }
}
