import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cart_cubit.dart';

class Product extends StatelessWidget {
  String? ProductId;
  Product({this.ProductId});
  @override
  Widget build(BuildContext context) {
    Color buttonColor = Color(0xff004CFF);
    final cubit = context.read<CartCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // محاذاة العناصر إلى اليسار
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                "lib/ecommerce/Image.jpg",
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16), // إضافة مسافة بين الصورة والنصوص
            Padding(
              padding: const EdgeInsets.only(left: 16.0), // إضافة مسافة من اليسار
              child: Text(
                "\$24.00", // إصلاح العلامة النقدية
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Raleway",

                ),
              ),
            ),
            SizedBox(height: 8), // إضافة مسافة
            Padding(
              padding: const EdgeInsets.only(left: 16.0), // إضافة مسافة من اليسار
              child: Text(
                "\$30.00", // السعر القديم
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway', // تأكد من استخدام الخط
                ),
              ),
            ),
            SizedBox(height: 8), // إضافة مسافة
            Padding(
              padding: const EdgeInsets.only(left: 16.0), // إضافة مسافة من اليسار
              child: Container(
                height: 200,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mauris, scelerisque eu mauris id, pretium pulvinar sapien.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15, // تقليل حجم الخط للنص
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16), // إضافة مسافة بين النص والزر
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: IconButton(
                icon: Icon(Icons.favorite), // أيقونة القلب الممتلئ
                color: Colors.red, // لون الأيقونة
                iconSize: 40.0, // حجم الأيقونة
                onPressed: () {
                  print('Heart icon pressed');
                },
              ),
            ),
            SizedBox(width: 60,),
            ElevatedButton(
              onPressed: () {
                cubit.addOrRemoveFromTheCart(ProductId!);
              },
              child: Text(
                "Add to Cart",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(

                minimumSize: Size(200, 50), // عرض وارتفاع الزر
                backgroundColor: buttonColor, // لون الزر
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // تقليل نصف القطر هنا
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
