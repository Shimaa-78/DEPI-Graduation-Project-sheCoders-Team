import 'ProducModel.dart';


class FavouriteModel {

  final List<FavoriteItem> items;


  FavouriteModel({

    required this.items,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['data'] as List;
    List<FavoriteItem> itemsList =
    itemsFromJson.map((item) => FavoriteItem.fromJson(item)).toList();

    return FavouriteModel(

      items: itemsList,

    );
  }
}

class FavoriteItem {
  final int id;
  final Product product;

  FavoriteItem({required this.id, required this.product});

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
    );
  }
}

