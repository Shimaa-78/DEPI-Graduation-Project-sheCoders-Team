// profile_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shoppe/Screens/LoginScreen.dart';

import '../Screens/startScreen.dart';
import '../helpers/hive_helper.dart'; // Assuming HiveHelper is in the helpers folder

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ImagePicker _picker = ImagePicker();

  ProfileCubit() : super(ProfileInitial());

  // Load initial profile data
  void loadProfile() async {
    final name = HiveHelper.getUserName() ?? "";
    final email = HiveHelper.getUserEmail() ?? "";
    final phone = HiveHelper.getUserPhoneNumber()?? "";
    // Simulate fetching profile from local storage
    final image = await _loadSavedImage();
    emit(ProfileLoaded(
      name: name,
      age: "",
      email: email,
      phonenumber: phone,
      gender: "",
      image: image,
      selectedLanguage: "English", // default language
      selectedCity: "Cairo",       // default city
    ));
  }

  // Update gender
  void updateGender(String gender) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(currentState.copyWith(gender: gender, image: currentState.image));
    }
  }

  // Update selected language
  void updateLanguage(String language) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(currentState.copyWith(selectedLanguage: language, image: currentState.image));
    }
  }

  // Update selected city
  void updateCity(String city) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(currentState.copyWith(selectedCity: city, image: currentState.image));
    }
  }

  // Pick image from source
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      final savedImage = await _saveImageToLocalDirectory(File(pickedFile.path));
      if (state is ProfileLoaded) {
        emit((state as ProfileLoaded).copyWith(image: savedImage));
      }
    }
  }

  // Delete profile image
  Future<void> deleteImage() async {
    if (state is ProfileLoaded) {
      emit((state as ProfileLoaded).copyWith(image: null));
    }
  }

  // Save image to local directory
  Future<File> _saveImageToLocalDirectory(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = "${directory.path}/profile_image.png";
    return image.copy(imagePath);
  }

  // Load saved image
  Future<File?> _loadSavedImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = "${directory.path}/profile_image.png";
    final savedImage = File(imagePath);

    if (await savedImage.exists()) {
      return savedImage;
    }
    return null;
  }
  // Logout method
  Future<void> logout() async {
    try {
      // Remove token from Hive (or wherever it is stored)
      await HiveHelper.removeToken();
           print("+============================ToKEN = ${HiveHelper.getToken()}");

      // Navigate to the login screen after successful logout
      Get.offAll(StartScreen());
      // emit(deletedToke());
      Get.offAll(LoginScreen());
    } catch (e) {
      // If an error occurs during logout
      emit(ProfileError('Logout failed. Please try again.'));
    }
  }
}



