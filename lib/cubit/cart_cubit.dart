import 'package:bloc/bloc.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:meta/meta.dart';
import 'package:shoppe/Consts/Kpis.dart';

import '../Helpers/DioHelper.dart';
import '../Models/CartModel.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartModel? cartModel;

  CartCubit() : super(CartInitial());



  Future<void> getUserCart() async {
    emit(CartLoading());
    try {
      final response = await DioHelper.getData(path: KApis.cartPath);
      print("API Response: ${response.data}");
      if (response.data['status']) {
        cartModel = CartModel.fromJson(response.data);
        print("Total amount: ${cartModel?.total}"); // Accessing the total
        emit(CartSuccess());
      } else {
        emit(CartError("Failed to load cart items"));
      }
    } catch (error) {
      emit(CartError("An error occurred: $error"));
    }
  }


}

