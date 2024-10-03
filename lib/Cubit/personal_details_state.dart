//
part of 'personal_details_cubit.dart';

@immutable
abstract class PersonalDetailsState {
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

class PersonalDetailsInitial extends PersonalDetailsState {
  const PersonalDetailsInitial()
      : super(
    isCurrentPasswordVisible: false,
    isNewPasswordVisible: false,
    currentPasswordError: null,
    newPasswordError: null,
  );
}

class PersonalDetailsUpdated extends PersonalDetailsState {
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

class PersonalDetailsLoading extends PersonalDetailsState {
  const PersonalDetailsLoading()
      : super(
    isCurrentPasswordVisible: false,
    isNewPasswordVisible: false,
  );
}

class PersonalDetailsSuccess extends PersonalDetailsState {
  final String message;

  const PersonalDetailsSuccess(this.message)
      : super(
    isCurrentPasswordVisible: false,
    isNewPasswordVisible: false,
  );
}

class PersonalDetailsError extends PersonalDetailsState {
  final String error;

  const PersonalDetailsError(this.error)
      : super(
    isCurrentPasswordVisible: false,
    isNewPasswordVisible: false,
  );
}


