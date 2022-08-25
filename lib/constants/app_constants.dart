import 'package:flutter/material.dart';

class AppConstants{
  static const TR_LOCALE=Locale("tr","TR");
  static const EN_LOCALE=Locale("en","US");
  static const LANG_PATH='assets/lang';

}

enum FormStatus {signIn,register}

TextEditingController signInEmailController=TextEditingController();
TextEditingController registeremailController=TextEditingController();
TextEditingController signInPasswordController=TextEditingController();
TextEditingController registerPasswordController=TextEditingController();
TextEditingController controlPasswordController=TextEditingController();
TextEditingController userNameController=TextEditingController();