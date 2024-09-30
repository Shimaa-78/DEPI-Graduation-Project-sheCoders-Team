// profile_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ImagePicker _picker = ImagePicker();

  ProfileCubit() : super(ProfileInitial());

  // Load initial profile data
  void loadProfile() async {
    // Simulate fetching profile from local storage
    final image = await _loadSavedImage();
    emit(ProfileLoaded(
      name: "",
      age: "",
      email: "",
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
}



