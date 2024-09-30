import 'package:flutter/material.dart';

class Favoritebutten extends StatelessWidget {
  Color buttonColor = Color(0xff004CFF);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: IconButton(
        icon: Icon(Icons.favorite), // أيقونة القلب الممتلئ
        color: Colors.red, // لون الأيقونة
        iconSize: 40.0, // حجم الأيقونة
        onPressed: () {
          print('Heart icon pressed');
        },
      ),
    );
  }
  }