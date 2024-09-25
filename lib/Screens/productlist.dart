import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  final List<String> productImages = [
    'https://s3-alpha-sig.figma.com/img/4e98/1e1f/88e55c19ce1aa419a238dff4dd3d7ee9?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=pPgfZxDv6goUHtjHIc6ULPDKkpFAMNwAhTc2rMoegwXvxhjVvsZMIkUK9H--FyHSquufQ7AdpWKZ0Gh8mRv~USvOaNTmfHFkRI7Hy9PyCZRXUjpVIqZwpm8kn1oCcu4VgAGe8dsmg5VG9ezQ-vmoomA0ln4n3DNxQxcFPOtG2VV19Tr2b0nza99Sq-uAqwhmlKIUQCri7bpjvyskQk0Q1Q8F81epgRVTD-Z2LPfmrTem-Gv4vtoTB52i9rz5a7Bi8RmmPDTQqg2thORirY7c95jCRAu~8eV903UYXDOkbt4dSBSCK8YYepfAffqZ~uXgFUU7dsxvgt8l80ZlJCIZxQ__',
    'https://s3-alpha-sig.figma.com/img/cc41/14d5/27454b7282c49edc81b76bb6c1314605?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=iAgaTCgXInWn-6aefKULfg461wgeZ95vwf2iAuXQsB8MpLWD1G2atiJKYEujkQYnNK6b9FHzrDBG6NzSuo8NZ6QIzYvq~noY8kdKKkjVwPbXcQfBpyWiKNl~tiz3Bo8XQ0nN2NIHQ0ao3JQucSUAnG72z0kZdRkRRJx9lnHQWU5sd7bxZXneHY5HG~Hq6STjIbb9YUj~i-MIzhy84dR0ApIKfUAcRM4~Y7ctLmaUIUZMK1bMq5vgFpzCk6xBUrhtRT0g21GzjLUdh--8PnT4CbeY~R4FRjvdTaKS33-NuHAw8~R2fKKvmAtVeQVzOWZvANJq1F7ZtKosOg6ML0S~Vw__',
    'https://s3-alpha-sig.figma.com/img/39a9/4b6c/b66665a43b8e7d98053af3ed69d2469a?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jfObyaakwWcWUPx-x33kk6dKxsrGBsDVaH7SmRNu2RwWnhPDV4M6lbkVtBJ5LiG19~0oRgw4Vq8qd~2ouZF-6OZyrTqz7R7CXBEcDQTcv-R2NUuyhvgMVosGTJUtgZ3z3WiUkaYomXYiP-IUSGKed8KWBRRaxBVamvvtImXg9jQWjrrwhebGBixRsdH7~m4FyjPdwWiuJDRdP6BILDyC9RvxHR7AHj6tUy2qa0CLj3BxmoRKZY8DWe9tYBNenKFd3L2CPaIFQV4cJHM7sIqU5qS3ZD423am6qishZlF75w9uiWM2ld4FqgKwwXwGot9D-tkuvXzBPQMB9gXaAG64FA__',
    'https://s3-alpha-sig.figma.com/img/3a39/f1d1/d23c65e543db966efd9955c99cf0a27a?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=SOrflaHk9DjHiTF~sDCNYaYCigKzotmFI5Fy7d5dYAUc8RMA~wSw18FOIRIFM~qZOhMBocxIdXJNA9-z3Ol~zMBlpqKs6A587uALI60hoZ5KnzeVpbAaMIlBt4B9-cSyXtdqaifgt79J2oliGeu~b6wYbje0pznMBuUUbp1nCbykkqwHXu4p5PrXnpClH6ipaJsqaAHcEJE3UnA0IGbh2BjYQOZRtN4icVqbBJPLQHxrdt2wiB0L9lLP4y65oK-eBqgwFd1udiftvPdnw80S-CQH55cmy4kT38AuFNn5QEE5e5M1TGJrK2XuPQXWSFxvaiuJ3ECXqJmZMBFTnMBsfQ__',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Products List',
          style: TextStyle(color: Colors.black),
        ),

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none, // Removing the border
                suffixIcon: Icon(Icons.search), // أيقونة البحث في نهاية الـ TextField
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: productImages.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              productImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lorem ipsum dolor sit amet consectetur',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$16.00',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$20.00',
                                    style: TextStyle(
                                      color: Colors.red,
                                      decoration:
                                      TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications), // العنصر الرابع
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), // العنصر الرابع
            label: 'cart',
          ),

        ],
        currentIndex: 0, // تأكد من تعيين الفهرس الحالي بشكل صحيح
        onTap: (index) {
          // تنفيذ الإجراء المناسب عند النقر على عنصر
        },
        backgroundColor: Colors.blue, // تغيير لون الخلفية هنا
        selectedItemColor: Colors.white, // لون العنصر المحدد
        unselectedItemColor: Color(0xff004CFF),
        // لون العناصر غير المحددة
      ),

    );
  }
}
