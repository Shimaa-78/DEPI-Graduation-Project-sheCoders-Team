import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe/Screens/favorite.dart';

import '../Screens/Cart.dart';

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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(

            icon: InkWell(child: Icon(Icons.shopping_cart),onTap: (){

              Get.to(CartScreen());
            },),
            label: 'Cart',
          ),
        ],
        currentIndex: 0,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xff004CFF),

    );
  }
}
