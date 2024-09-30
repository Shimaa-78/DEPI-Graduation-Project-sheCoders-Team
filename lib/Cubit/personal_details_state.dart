part of 'personal_details_cubit.dart';

@immutable
sealed class PersonalDetailsState {
  final bool isCurrentPasswordVisible;
  final bool isNewPasswordVisible;
  final String? currentPasswordError;
  final String? newPasswordError;

  const PersonalDetailsState({
    required this.isCurrentPasswordVisible,
    required this.isNewPasswordVisible,
    this.currentPasswordError,
    this.newPasswordError,
  });
}

final class PersonalDetailsInitial extends PersonalDetailsState {
  const PersonalDetailsInitial()
      : super(
    isCurrentPasswordVisible: false,
    isNewPasswordVisible: false,
    currentPasswordError: null,
    newPasswordError: null,
  );
}

final class PersonalDetailsUpdated extends PersonalDetailsState {
  const PersonalDetailsUpdated({
    required bool isCurrentPasswordVisible,
    required bool isNewPasswordVisible,
    String? currentPasswordError,
    String? newPasswordError,
  }) : super(
    isCurrentPasswordVisible: isCurrentPasswordVisible,
    isNewPasswordVisible: isNewPasswordVisible,
    currentPasswordError: currentPasswordError,
    newPasswordError: newPasswordError,
  );
}
