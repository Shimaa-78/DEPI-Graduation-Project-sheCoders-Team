import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../Models/categorymodel.dart';
import 'package:meta/meta.dart';
import '../helpers/dio_helper.dart';
import '../Consts/KApis.dart';


part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  // Define Dio for making the API request


  // Fetch categories from API
  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final response = await  DioHelper.getData(path:  KApis.categories);
      if (response.statusCode == 200) {
        List<CategoryModel> categories = (response.data['data']['data'] as List)
            .map((item) => CategoryModel.fromJson(item))
            .toList();
        emit(CategoryLoaded(categories: categories));
      } else {
        emit(CategoryError(message: 'Failed to fetch categories'));
      }
    } catch (error) {
      emit(CategoryError(message: "An error occurred Check Your Internet Connection"));
    }
  }
}
/////////////////////