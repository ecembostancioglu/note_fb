import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/onboarding_view/onboard_view.dart';
import 'package:todo_fb/onboarding_view/presentation/view/login.dart';

import 'main.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360,690),
      builder: (context,widget)
      =>
          MultiProvider(
            providers: [
            Provider<AuthService>(
            create:(context)=>AuthService(),),
         // ChangeNotifierProvider<UploadImageProvider>(
         //     create:(context)=>UploadImageProvider()),
        ],
          child:MaterialApp(
          debugShowCheckedModeBanner: false,
           localizationsDelegates: context.localizationDelegates,
           supportedLocales: context.supportedLocales,
           locale: context.locale,
           home: isViewed !=0
               ? OnBoardView()
               : LoginPage()
        ),
          )
    );
  }
}
