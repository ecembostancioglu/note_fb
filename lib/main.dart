import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_fb/app.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'translations/codegen_loader.g.dart';

int? isViewed;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs=await SharedPreferences.getInstance();
  isViewed=prefs.getInt('onBoard');
  runApp(
      EasyLocalization(
          child:MyApp(),
          saveLocale: true,
          fallbackLocale: AppConstants.EN_LOCALE,
          assetLoader: CodegenLoader(),
          supportedLocales: const[
            AppConstants.EN_LOCALE,
            AppConstants.TR_LOCALE],
          path: AppConstants.LANG_PATH));
}
