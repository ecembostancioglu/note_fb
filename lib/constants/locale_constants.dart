import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

class LocaleConstants{
  static const TR_LOCALE=Locale("tr","TR");
  static const EN_LOCALE=Locale("en","US");
  static const LANG_PATH='assets/lang';
  static String email='Email'.myLocale;
  static String password='Password'.myLocale;
  static String loginwithGoogle='Login with Google'.myLocale;
}


extension LocaleExtension on String{
  String get myLocale=> this.tr().toString();
}