// import 'package:depi/favorite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FavoritesProvider with ChangeNotifier {
  List<String> _productImages = [
    'https://s3-alpha-sig.figma.com/img/39a9/4b6c/b66665a43b8e7d98053af3ed69d2469a?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jfObyaakwWcWUPx-x33kk6dKxsrGBsDVaH7SmRNu2RwWnhPDV4M6lbkVtBJ5LiG19~0oRgw4Vq8qd~2ouZF-6OZyrTqz7R7CXBEcDQTcv-R2NUuyhvgMVosGTJUtgZ3z3WiUkaYomXYiP-IUSGKed8KWBRRaxBVamvvtImXg9jQWjrrwhebGBixRsdH7~m4FyjPdwWiuJDRdP6BILDyC9RvxHR7AHj6tUy2qa0CLj3BxmoRKZY8DWe9tYBNenKFd3L2CPaIFQV4cJHM7sIqU5qS3ZD423am6qishZlF75w9uiWM2ld4FqgKwwXwGot9D-tkuvXzBPQMB9gXaAG64FA__',
    'https://s3-alpha-sig.figma.com/img/3b47/e061/26ae09cc2e56bc0cfdbbcad80ef5aa67?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Wdl~UYU95vjm3kFtAtF~g77-5gcdwy8ZwBIL~~PD4q1e-zUbrRn~SrohnT3ih~1g~1VYWujc7jbKHA0whrb1A6s6Bh~MQbZQhgQYds2eT-yng8-KVHtxKHzfqyb2yhMffLF7Gw83TVgWVrTMkF1D-GgsgFMRddZElZPbslj3ldlkW1gUgn0TrmXqWh~CoJH25~dll8gN30K47AOV3HVUmpqgGW3gHR1WVjLCHSWdEk2dxMaIutZOepc~lRSvFp-3Zogo~fa7waOX-XYeXyAnVAw3h5iS4r89v1WQAn-uRWVCO9qwRHX4E7Sbc20S3Sk7CLCaXBCZWX2fFcUQZOcfhw__',
    'https://s3-alpha-sig.figma.com/img/337a/22ae/49b350434fc9e50a9abb7351559ff374?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mfgAuh3zXGbKP7zVuJJpTfAfwvE~NvR63ttFofY5JJNnbrvrnNaCHp8TOHJWECCPS9TDihqGcvZ~tO~Yen32lnmt0heN-j1Ag4-he-wWlPfCVHFFh~8NznyPaqlCejSdWq14dvAynXWKA0rFduZMYbpP7CABjxx9OPeXeEHm0RfzwM9FurKloMNMMkLKFyEMjxcvPcEO6CkRKH~2VQb5HdI4wYpVmyVX-v5TQdkH5OBWW9Iv1wHwTJBolno2RGY8R~W150DiFYNV-DHy9O9Hj7d~q7vJkVqguS-WhwM0pu3b77dhwm9pveDqpt1o1LTHIEhH5~mJQwULVnCqQCGnhQ__',
    'https://s3-alpha-sig.figma.com/img/29fa/e184/053666ddc17b71621107f3fdefffc22d?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=janKctTaQJqRgHeILnwcTHWm4gJRCmNp14kuytRx1TpyB7bTw7JtSObFtX7P1WM27BG1aqGLZ3v9o~A~kyM1G-Pndr~gYgbbo~rIo1TG96ulIYuGymnLaSR67xhftP13DPt2bPkngHtHyenmPiWWk~5W9sCVqL9f~MCEdc7ufF9nodPRjoXP~ctXrqIfRENiV4MhZaw0fqc1mgI-sVTmraG6uap34e8YlsLxJDGDxwj9CytshVkHxc4yxqzJs3FF-xvrBjvES88PyTSXtTNl1jTbIrl9LZFpzOqsuxUxz-KNu5C2T8yOjB9e8jk4hAFbthMUHIl2aELp7A3hoYYLow__',
    'https://s3-alpha-sig.figma.com/img/cc41/14d5/27454b7282c49edc81b76bb6c1314605?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=iAgaTCgXInWn-6aefKULfg461wgeZ95vwf2iAuXQsB8MpLWD1G2atiJKYEujkQYnNK6b9FHzrDBG6NzSuo8NZ6QIzYvq~noY8kdKKkjVwPbXcQfBpyWiKNl~tiz3Bo8XQ0nN2NIHQ0ao3JQucSUAnG72z0kZdRkRRJx9lnHQWU5sd7bxZXneHY5HG~Hq6STjIbb9YUj~i-MIzhy84dR0ApIKfUAcRM4~Y7ctLmaUIUZMK1bMq5vgFpzCk6xBUrhtRT0g21GzjLUdh--8PnT4CbeY~R4FRjvdTaKS33-NuHAw8~R2fKKvmAtVeQVzOWZvANJq1F7ZtKosOg6ML0S~Vw__',
    'https://s3-alpha-sig.figma.com/img/6a6a/7129/1fde341b60adcf3abb0c9f834bcf0398?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kZfHSXpdnsUmwkYgNGVASYwsCz~yF8e95HnxGKYhbORft8HTefFGhJSc1b3MRWfkQsa65G2hmbt6hV3P42yM39YJHfqHn7ouEEAs-S6nRr~in8DYUZp1Zv9iRj5L6nrRNfH-a27QnR7TMU0EAzJmpHnXk0Y5eHA9~-k5K4KjBosSPM8hfZt2e7m8~HeEgicBz47LIE~Y~G4gPrSBrEf9RBbPp15Xg1vEGTZKsaMXZOq3-Pi6H85xyim4KB1BTqxLWa-It6U8HY1RjnwvSol47IAr0yLqHrKBkB-DrDkIuw-CJSxljD95U0n0n9NwmEQKtAxTKps1OIhC~d2~GPETfg__',
    'https://s3-alpha-sig.figma.com/img/3a39/f1d1/d23c65e543db966efd9955c99cf0a27a?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=SOrflaHk9DjHiTF~sDCNYaYCigKzotmFI5Fy7d5dYAUc8RMA~wSw18FOIRIFM~qZOhMBocxIdXJNA9-z3Ol~zMBlpqKs6A587uALI60hoZ5KnzeVpbAaMIlBt4B9-cSyXtdqaifgt79J2oliGeu~b6wYbje0pznMBuUUbp1nCbykkqwHXu4p5PrXnpClH6ipaJsqaAHcEJE3UnA0IGbh2BjYQOZRtN4icVqbBJPLQHxrdt2wiB0L9lLP4y65oK-eBqgwFd1udiftvPdnw80S-CQH55cmy4kT38AuFNn5QEE5e5M1TGJrK2XuPQXWSFxvaiuJ3ECXqJmZMBFTnMBsfQ__',
    'https://s3-alpha-sig.figma.com/img/e4a7/fe8f/bdc5579f712678cfdcb997655d89f238?Expires=1728259200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=DbE9P7DWr1h7WaHxrJCTBn6Gc~QXtn3BHT94C56FKNQKFligSySS9Mwy1A-ngniDUfaaCSXAG6uGNX2qwXHX5cgO9EJCnVw323dY6JrhoCii7TKNgyJXGqV-f88yeLyrBTUEv5QK9XPNqI4RYKex2-5cD6U-47kaaaGzRUVT4y2FtdE3fWatDn~nV4pHgv10phKhw7Yu04tzoolX5gzCEAok8Z2vpb0NGrrowIOZGsrWED8X16ZyWSKsh34aW3Yuy9tCuidGcc7rA6tWzBOhC8EZdb5SmDczsHgGuH2H5gqgjQP6pdC39kc8lp3X88Ua-89lnptwloUvxwpM~x38Mg__',

  ];

  List<double> _productPrices = [
    20.0,
    30.0,
    25.0,
    50.0,
    40.0,
    60.0,
    75.0,
    80.0,
  ];

  List<String> get productImages => _productImages;
  List<double> get productPrices => _productPrices;

  void removeProduct(int index) {
    _productImages.removeAt(index);
    _productPrices.removeAt(index);
    notifyListeners();
  }
}

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Favorites', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: favoriteProvider.productImages.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  favoriteProvider.productImages[index],
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet consectetur',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${favoriteProvider.productPrices[index].toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red, size: 15),
                        onPressed: () {
                          favoriteProvider.removeProduct(index);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.blue),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.grey),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

