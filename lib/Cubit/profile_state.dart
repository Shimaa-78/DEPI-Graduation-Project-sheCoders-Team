// profile_state.dart
part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String age;
  final String email;
  final String gender;
  final File? image;
  final String selectedLanguage;
  final String selectedCity;

  ProfileLoaded({
    required this.name,
    required this.age,
    required this.email,
    required this.gender,
    required this.image,
    required this.selectedLanguage,
    required this.selectedCity,
  });

  // Method to copy the profile state and update specific fields
  ProfileLoaded copyWith({
    String? name,
    String? age,
    String? email,
    String? gender,
    File? image,
    String? selectedLanguage,
    String? selectedCity,
  }) {
    return ProfileLoaded(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      image: image,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedCity: selectedCity ?? this.selectedCity,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}




