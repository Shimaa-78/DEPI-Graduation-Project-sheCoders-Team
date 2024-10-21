import 'package:hive/hive.dart';

class HiveHelper {
  static const onboardingBox = "ONBOARDING_BOX";
  static const token = "TOKEN";
  //static const KEY_BOX_APP_LANGUAGE = "KEY_BOX_APP_LANGUAGE";
  static const KEY_USER_NAME = "USER_NAME";
  static const KEY_USER_EMAIL = "USER_EMAIL";
  static const userPhoneNumber = "USER_PHONE_NUMBER";
  static const userBox = "USER_BOX";
  static const KEY_BOX_APP_LANGUAGE = "KEY_BOX_APP_LANGUAGE";



  static void setValueInOnboardingBox() {
    Hive.box(onboardingBox).put(onboardingBox, true);
  }

  static bool checkOnBoardingValue() {
    if (Hive.box(onboardingBox).isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static void setToken(String tokenParam) {
    Hive.box(token).put(token, tokenParam);
  }

  static String? getToken() {
    if (Hive.box(token).isNotEmpty) {
      return Hive.box(token).get(
        token,
      );
    }
    return null;
  }

  // User Name
  static void setUserName(String name) {
    Hive.box(userBox).put('USER_NAME', name);
  }

  static String? getUserName() {
    return Hive.box(userBox).get('USER_NAME');
  }

  static void setUserEmail(String email) {
    Hive.box(userBox).put('USER_EMAIL', email);
  }

  static String? getUserEmail() {
    return Hive.box(userBox).get('USER_EMAIL');
  }
  // Store User Phone Number
  static void setUserPhoneNumber(String phoneNumber) {
    Hive.box(userPhoneNumber).put(userPhoneNumber, phoneNumber);
  }

  // Get User Phone Number
  static String? getUserPhoneNumber() {
    if (Hive.box(userPhoneNumber).isNotEmpty) {
      return Hive.box(userPhoneNumber).get(userPhoneNumber);
    }
    return null;
  }
  // Remove token (for logout)
  static Future<void> removeToken() async {
    var box = await Hive.openBox(token);
    await box.delete('token');
  }

  static void setLanguage(String langCode) async {
    Hive.box(KEY_BOX_APP_LANGUAGE).put(KEY_BOX_APP_LANGUAGE, langCode);
  }

  static String getLanguage() {
    return Hive.box(KEY_BOX_APP_LANGUAGE).get(KEY_BOX_APP_LANGUAGE) ?? "en";
  }

  // static String? getToken() {
  //   if (Hive.box(token).isNotEmpty) {
  //     return Hive.box(token).get(
  //       token,
  //     );
  //   }
  //   return null;
  // }

}
