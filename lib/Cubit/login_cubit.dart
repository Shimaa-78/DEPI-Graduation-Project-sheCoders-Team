import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shoppe/Screens/ForgetPassword.dart';
import 'package:shoppe/Screens/sign%20out.dart';
import '../Consts/KApis.dart';
import '../Models/LoginModel.dart';
import '../helpers/dio_helper.dart';
import '../helpers/hive_helper.dart';
part 'login_state.dart';

String generateRandomPhone() {
  final random = Random();
  // توليد رقم هاتف عشوائي مكون من 11 رقمًا يبدأ بـ 07 ويليه 9 أرقام عشوائية
  return '07${random.nextInt(900000000) + 100000000}';
}


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  LoginModel model = LoginModel();
  void login({
    required String email,
    required String password,
    String? name,
    String? phone,
    bool isRegister = false,
  }) async {
    emit(LoginLoadingState());
    try {
      final response = await DioHelper.postData(
        path: isRegister ? KApis.register : KApis.login,
        body: {
          "email": email,
          "password": password,
          if (isRegister) "name": name,
          if (isRegister) "phone": phone,
        },
      );
      model = LoginModel.fromJson(response.data);
      if (model.status == true) {
        HiveHelper.setToken(model.data?.token ?? "");
        Get.offAll(() => ForgetPassword());

        emit(LoginSuccessState(model.message ?? ""));
      } else {
        emit(LoginErrorState(model.message ?? ""));
      }
    } catch (e) {
      emit(LoginErrorState("Connection is bad"));
    }
  }

  bool obscure = false;

  void changeSuffix() {
    emit(LoginInitial());
    obscure = !obscure;
    emit(AuthChangeSuffix());
  }
  String generateRandomPhoneNumber() {
    final random = Random();
    // توليد رقم هاتف عشوائي مكون من 11 رقمًا يبدأ بـ 07 ويليه 9 أرقام عشوائية
    return '07${random.nextInt(900000000) + 100000000}';
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoadingState()); // إشعار ببدء العملية

    try {
      final GoogleSignIn googleUser = GoogleSignIn();

      // تحقق مما إذا كان المستخدم قد قام بتسجيل الدخول مسبقًا وتسجيل الخروج
      if (await googleUser.isSignedIn()) {
        googleUser.currentUser?.clearAuthCache();
        googleUser.signOut();
      }

      // بدء عملية تسجيل الدخول بحساب Google
      final user = await googleUser.signIn();
      if (user != null) {
        final GoogleSignInAuthentication googleAuth = await user.authentication;

        // إعداد بيانات المستخدم لإرسالها إلى API


        // إرسال بيانات المستخدم إلى API
        final response = await DioHelper.postData(
          path: KApis.login, // استبدل بـ endpoint الصحيح
          body: {
            "email": user.email,
            "password": "1234567",
            "name":user.displayName,
            "phone": generateRandomPhoneNumber(),
          },
        );

        // طباعة الاستجابة من الـ API لأغراض التصحيح
        print('Response Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');


        if (response.statusCode == 200) {
          model = LoginModel.fromJson(response.data);
          if (model.status == true) {
            // حفظ التوكن أو أي بيانات أخرى حسب الحاجة
            HiveHelper.setToken(model.data?.token ?? "");
            Get.offAll(() => SignOut()); // الانتقال إلى الصفحة الرئيسية أو أي صفحة أخرى
            emit(LoginSuccessState(model.message ?? ""));
          } else {
            emit(LoginErrorState(model.message ?? ""));
          }
        } else {
          emit(LoginErrorState("Failed to send data to API. Status Code: ${response.statusCode}"));
        }
      }
    } catch (error) {
      debugPrint(error.toString());
      emit(LoginErrorState("Error during Google sign-in")); // التعامل مع الخطأ
    }
  }



}


