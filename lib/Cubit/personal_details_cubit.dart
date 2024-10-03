import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../Consts/KApis.dart';
import '../helpers/dio_helper.dart';
import '../helpers/hive_helper.dart';

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

  // Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final token = HiveHelper.getToken(); // Retrieve token from Hive

    if (token == null) {
      emit(PersonalDetailsError("No token found, please log in again."));
      return;
    }

    emit(PersonalDetailsLoading());

    try {
      final response = await DioHelper.postData(
        path: KApis.changePassword,
        body: {
          "current_password": currentPassword,
          "new_password": newPassword,
        },
        queryParameters: {
          "Authorization": "Bearer $token" // Pass token for authentication
        },
      );

      if (response.data['status']) {
        emit(PersonalDetailsSuccess("Password changed successfully!"));
      } else {
        emit(PersonalDetailsError(response.data['message'] ?? "Failed to change password"));
      }
    } catch (error) {
      emit(PersonalDetailsError("Error occurred while changing password"));
    }
  }
}




