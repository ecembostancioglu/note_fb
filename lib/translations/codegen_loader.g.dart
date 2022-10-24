// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en_US = {
  "authentication": {
    "email": "Email",
    "password": "Password",
    "loginwithGoogle": "Login with Google",
    "login": "Login",
    "signupButton": "Don't have an account? SIGN UP",
    "name": "Name",
    "confirm_password": "Confirm Password"
  }
};
static const Map<String,dynamic> tr_TR = {
  "authentication": {
    "email": "Email adresi",
    "password": "Şifre",
    "loginwithGoogle": "Google ile Giriş Yap",
    "login": "Giriş Yap",
    "signupButton": "Hesabın yok mu? ÜYE OL",
    "name": "İsim",
    "confirm_password": "Şifreyi Yinele"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {
  "en_US": en_US,
  "tr_TR": tr_TR};
}
