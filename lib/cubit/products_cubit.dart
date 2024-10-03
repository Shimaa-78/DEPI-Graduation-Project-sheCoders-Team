import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../Models/categorymodel.dart';
import '../Models/ProducModel.dart';
import '../helpers/dio_helper.dart';
import '../Consts/KApis.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());


  // Fetch products from API based on category ID
  Future<void> fetchProducts(int id) async {
    emit(ProductsLoading());
    try {
      final response = await   DioHelper.getData(path:  KApis.products,queryParameters: {"category_id":id});
      if (response.statusCode == 200) {
        List<Product> products = (response.data['data']['data'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
        emit(ProductsLoaded(products: products));
      } else {
        emit(ProductsError(message: 'Failed to fetch products'));
      }
    }  catch (error) {
      emit( ProductsError(message: "An error occurred Check Your Internet Connection"));
    }
  }
}
/////////////////////
/////////////////////