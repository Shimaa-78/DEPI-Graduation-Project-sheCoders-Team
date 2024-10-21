
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/search_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Screens/productSearch.dart';// Make sure to import the correct cubit


class Textfieldsearch extends StatefulWidget {
  @override
  _TextfieldsearchState createState() => _TextfieldsearchState();
}

class _TextfieldsearchState extends State<Textfieldsearch> {
  // تعريف TextEditingController للتحكم في TextField
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller, // ربط الـ TextField بالـ controller
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.search,
          border: InputBorder.none, // إزالة الحدود
          suffixIcon: InkWell(
            onTap: () {
              // الحصول على النص الموجود في الـ TextField
              String searchText = _controller.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) {
                      final cubit =   SearchCubit (); // إنشاء CategoryCubit
                      cubit.fetchProducts(searchText); // استدعاء fetchCategories هنا
                      return cubit; // إرجاع الـ cubit
                    },
                    child:ProductsearchScreen(), // الشاشة التي يتم التنقل إليها
                  ),
                ),
              );
            },
            child: Icon(Icons.search), // أيقونة البحث في نهاية الـ TextField
          ),
        ),
      ),
    );
  }



}







