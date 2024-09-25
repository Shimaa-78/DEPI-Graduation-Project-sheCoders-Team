import 'package:flutter/material.dart';
import '../Models/categorymodel.dart';
import 'categories.dart';
class Categorylistview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories=[
      CategoryModel(image: "https://student.valuxapps.com/storage/uploads/categories/16893929290QVM1.modern-devices-isometric-icons-collection-with-sixteen-isolated-images-computers-periphereals-variou.jpeg",categoryName: "Electronic devices"),
      CategoryModel(image: "https://student.valuxapps.com/storage/uploads/categories/1630142480dvQxx.3658058.jpg",categoryName: "Corona vaccine"),

      CategoryModel(image:  "https://student.valuxapps.com/storage/uploads/categories/16445270619najK.6242655.jpg",categoryName: "sports"),
      CategoryModel(image:  "https://student.valuxapps.com/storage/uploads/categories/16445230161CiW8.Light bulb-amico.png",categoryName: "Lighting devices"),
      CategoryModel(image:  "https://student.valuxapps.com/storage/uploads/categories/1644527120pTGA7.clothes.png",categoryName:  "clothes"),
      CategoryModel(image: "https://student.valuxapps.com/storage/uploads/categories/1722697946gR5Og.Grocery-shop-basket-med.jpg" ,categoryName: "grocery"),
    ];
     return
       ListView.builder(
        itemCount: categories.length,

        itemBuilder: (context, index) {
          return   CategoryWidget (categoryModel:categories[index] ,);
        },
      );

  }}