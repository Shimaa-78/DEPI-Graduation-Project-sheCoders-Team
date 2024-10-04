import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/favorite.dart';
import '../Screens/Cart.dart';



class  Bottomnavigationbar extends StatefulWidget {
  @override
  _BottomNavigationBarExampleState createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State< Bottomnavigationbar> {




  @override
  Widget build(BuildContext context) {


     return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.shopping_cart),
          //   label: 'Cart',
          // ),
        ],

        // backgroundColor: Colors.black, // لون خلفية غامق للتأكد من وضوح الأيقونات
        // selectedItemColor: Colors.white, // اللون الأبيض للعناصر المختارة
        // unselectedItemColor: Colors.grey, // اللون الرمادي للعناصر غير المختارة

    );
  }
}
