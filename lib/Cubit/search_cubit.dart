import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../Models/categorymodel.dart';
import '../Models/ProducModel.dart';
import 'package:meta/meta.dart';
import '../helpers/dio_helper.dart';
import '../Consts/KApis.dart';


part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  Future<void> fetchProducts( String search) async {
    emit(SearchsLoading());
    try {
      final response = await DioHelper.postData(path: KApis.search,body: {"text":search});
      if (response.statusCode == 200) {
        List<Product> products = (response.data['data']['data'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
        emit( SearchSucess(products: products));
      } else {
        emit( SearchError(message: 'Failed to fetch products'));
      }
    }   catch (error) {
      emit(SearchError(
          message: "An error occurred Check Your Internet Connection"));
    }
  }
}


