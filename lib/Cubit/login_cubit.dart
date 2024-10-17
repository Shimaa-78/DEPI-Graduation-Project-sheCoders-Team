import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'package:shoppe/Screens/ForgetPassword.dart';
import '../Consts/KApis.dart';
import '../Models/LoginModel.dart';
import '../Screens/home.dart';
import '../helpers/dio_helper.dart';
import '../helpers/hive_helper.dart';

part 'login_state.dart';

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
        Get.offAll(() =>  HomeScreen());

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
    // Generate an 11-digit phone number starting with 07 followed by 9 indirect digits
    return '07${random.nextInt(900000000) + 100000000}';
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoadingState());

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Check if the user has previously logged in and logged out
      if (await googleSignIn.isSignedIn()) {
        googleSignIn.currentUser?.clearAuthCache();
        googleSignIn.signOut();
      }

      // Start the Google account sign-in process
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        // Get credential from Firebase using token
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Log in to Firebase using credential
        final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

        // If the login is successful, you get the user data from Firebase
        final User? firebaseUser = userCredential.user;
        if (firebaseUser != null) {
          // User data from Firebase
          final loginData = {
            "name": firebaseUser.displayName,
            "email": firebaseUser.email,
            "phone": generateRandomPhoneNumber(),
            "uid": firebaseUser.uid,
          };

          // Send user data to API (if you need to send data to another server)
          final response = await DioHelper.postData(
            path: KApis.login,
            body: {
              "email": "nehal202124623@gmail.com",
              "password": "1234567",
              "name": "Nehal Khaled",
              "phone": generateRandomPhoneNumber(),
            },
          );

          print('Response Status Code: ${response.statusCode}');
          print('Response Data: ${response.data}');

          if (response.statusCode == 200) {
            model = LoginModel.fromJson(response.data);
            if (model.status == true) {
              HiveHelper.setToken(model.data?.token ?? "");
              Get.offAll(() => HomeScreen());
              emit(LoginSuccessState(model.message ?? ""));
            } else {
              emit(LoginErrorState(model.message ?? ""));
            }
          } else {
            emit(LoginErrorState(
                "Failed to send data to API. Status Code: ${response.statusCode}"));
          }
        }
      }
    } catch (error) {
      debugPrint(error.toString());
      emit(LoginErrorState("Error during Google sign-in"));
    }
  }
  //
  String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Please enter a phone number';
    }
    final RegExp phoneRegExp = RegExp(r'^[0-9]{11}$');
    if (!phoneRegExp.hasMatch(phone)) {
      return 'Please enter a valid phone number with 11 digits';
    }
    return null;
  }

  String? validateEmail(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'Please enter email';
    }
    final bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    ).hasMatch(text);
    if (!emailValid) {
      return "This field should be a valid email";
    }
    return null;
  }
  String? validatePassword(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'Please enter password';
    }
    if (text.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }
  // Change Password Method
  void changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(LoginLoadingState());

    try {
      // Call the API to change the user's password
      final token = HiveHelper.getToken();
      final response = await DioHelper.postData(
        path: KApis.changePassword,
        body: {
          "current_password": currentPassword,
          "new_password": newPassword,

        },

        queryParameters: {
          'Authorization': 'Bearer $token',
        },

      );
      print('Response: ${response.data}');
      print('Current Password: $currentPassword');
      print('New Password: $newPassword');


      if (response.statusCode == 200 && response.data['status'] == true) {
        emit(ChangePasswordSuccessState("Password changed successfully!"));
      } else {
        print('Failed with status code: ${response.statusCode}');
        emit(ChangePasswordErrorState("Failed to change password."));
      }

    } catch (e) {
      print('Error during password change: $e');
      emit(ChangePasswordErrorState("Connection failed!"));
    }
  }


}