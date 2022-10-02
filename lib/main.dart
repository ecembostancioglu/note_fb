import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_fb/app.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/database/repository/image_provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  UploadImageProvider().initSharedPreferences();
  runApp(
      EasyLocalization(
          child: MyApp(),
          saveLocale: true,
          fallbackLocale: AppConstants.EN_LOCALE,
          supportedLocales: const[
            AppConstants.EN_LOCALE,
            AppConstants.TR_LOCALE ],
          path: AppConstants.LANG_PATH));
}
