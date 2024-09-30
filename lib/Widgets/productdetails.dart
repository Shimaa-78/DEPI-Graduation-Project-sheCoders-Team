import 'package:flutter/material.dart';
import '../Models/ProducModel.dart';
class Productdetails extends StatelessWidget {
  Product product;
  Productdetails({ required this.product});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start, // محاذاة العناصر إلى اليسار
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          child:  Image.network(
            product.image,
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16), // إضافة مسافة بين الصورة والنصوص
        Padding(
          padding: const EdgeInsets.only(left: 16.0), // إضافة مسافة من اليسار
          child: Text(
             product.price.toString(),
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
           product.oldPrice.toString(),
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
              product.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15, // تقليل حجم الخط للنص
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
