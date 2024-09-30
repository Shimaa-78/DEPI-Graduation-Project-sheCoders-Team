import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'personal_details_state.dart';

class PersonalDetailsCubit extends Cubit<PersonalDetailsState> {
  PersonalDetailsCubit() : super(const PersonalDetailsInitial());

  // Toggle current password visibility
  void toggleCurrentPasswordVisibility() {
    emit(PersonalDetailsUpdated(
      isCurrentPasswordVisible: !state.isCurrentPasswordVisible,
      isNewPasswordVisible: state.isNewPasswordVisible,
      currentPasswordError: state.currentPasswordError,
      newPasswordError: state.newPasswordError,
    ));
  }

  // Toggle new password visibility
  void toggleNewPasswordVisibility() {
    emit(PersonalDetailsUpdated(
      isCurrentPasswordVisible: state.isCurrentPasswordVisible,
      isNewPasswordVisible: !state.isNewPasswordVisible,
      currentPasswordError: state.currentPasswordError,
      newPasswordError: state.newPasswordError,
    ));
  }

  // Validate current password
  void validateCurrentPassword(String? value) {
    final error = (value == null || value.length < 5)
        ? "Password is too short (minimum 5 characters)."
        : null;
    emit(PersonalDetailsUpdated(
      isCurrentPasswordVisible: state.isCurrentPasswordVisible,
      isNewPasswordVisible: state.isNewPasswordVisible,
      currentPasswordError: error,
      newPasswordError: state.newPasswordError,
    ));
  }

  // Validate new password
  void validateNewPassword(String? value) {
    final error = (value == null || value.length < 5)
        ? "Password is too short (minimum 5 characters)."
        : null;
    emit(PersonalDetailsUpdated(
      isCurrentPasswordVisible: state.isCurrentPasswordVisible,
      isNewPasswordVisible: state.isNewPasswordVisible,
      currentPasswordError: state.currentPasswordError,
      newPasswordError: error,
    ));
  }

  // Save details logic
  void saveDetails() {
    // Add your logic for saving the form details here
  }
}

