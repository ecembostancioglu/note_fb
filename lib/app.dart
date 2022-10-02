import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/authentication/presentation/view/auth_page.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/notes/database/repository/image_provider.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360,690),
        builder: (context,widget)
        => MultiProvider(
            providers: [
            ChangeNotifierProvider<AuthService>(
            create:(context)=>AuthService(),),
             ChangeNotifierProvider<UploadImageProvider>(
             create:(context)=>UploadImageProvider()),
        ],
          child:MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: FutureBuilder(
              future: _initialization,
              builder: (context,snapshot){
                if(snapshot.hasError){
                  return const Center(
                    child: Text('Something went wrong'),);
                }else if(snapshot.hasData){
                  return AuthPage();
                }
                return const Center(
                    child:CircularProgressIndicator());
              }
          ),
        ),
    ),

        );
  }
}