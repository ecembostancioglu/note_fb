import 'package:flutter/material.dart';

class AppConstants{
  static const TR_LOCALE=Locale("tr","TR");
  static const EN_LOCALE=Locale("en","US");
  static const LANG_PATH='assets/lang';


  //Form Errors

  static RegExp emailValidatorRegExp=RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String kEmailNullError='Please enter your Email';
  static const String kInvalidEmailError='Please enter valid Email';
  static const String kPassNullError='Please enter your password';
  static const String kShortPassError='Password is too short';
  static const String kMatchPassError='Passwords don\'t match';
}

enum FormStatus {signIn,register}