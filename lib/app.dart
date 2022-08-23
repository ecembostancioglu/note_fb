import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_fb/authentication/presentation/view/auth_page.dart';

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _initialization,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text('Something went wrong'),);
          }else if(snapshot.hasData){
             return AuthPage();
          }
          return Center(
              child:CircularProgressIndicator());
        }
      ),
    );
  }
}