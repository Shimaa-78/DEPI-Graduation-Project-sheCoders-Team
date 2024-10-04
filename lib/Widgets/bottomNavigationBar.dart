import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe/Screens/favorite.dart';

import '../Screens/Cart.dart';
import '../Screens/profile_screen.dart';

class  Bottomnavigationbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
       BottomNavigationBar(

        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell(child: Icon(Icons.favorite),onTap: (){
              Get.to(FavouriteScreen());
            },),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: InkWell(child: Icon(Icons.person),onTap: (){
              Get.offAll(ProfilePage());
            },),
            label: 'Profile',
          ),
          BottomNavigationBarItem(

            icon: InkWell(child: Icon(Icons.shopping_cart),onTap: (){

              Get.offAll(CartScreen());
            },),
            label: 'Cart',
          ),
        ],
        currentIndex: 0,
        backgroundColor: Colors.blue,

        unselectedItemColor: Color(0xff004CFF),

    );
  }
}
