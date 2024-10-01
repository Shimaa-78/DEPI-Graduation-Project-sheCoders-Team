import 'ProducModel.dart';

class FavouriteModel {
  final bool status;
  final String? message;
  final Data data;

  FavouriteModel({required this.status, this.message, required this.data});

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final int currentPage;
  final List<FavoriteItem> items;
  final String firstPageUrl;
  final String lastPageUrl;
  final int total;

  Data({
    required this.currentPage,
    required this.items,
    required this.firstPageUrl,
    required this.lastPageUrl,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['data'] as List;
    List<FavoriteItem> itemsList =
    itemsFromJson.map((item) => FavoriteItem.fromJson(item)).toList();

    return Data(
      currentPage: json['current_page'],
      items: itemsList,
      firstPageUrl: json['first_page_url'],
      lastPageUrl: json['last_page_url'],
      total: json['total'],
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

