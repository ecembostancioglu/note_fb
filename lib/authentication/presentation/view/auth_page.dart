import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/presentation/view/dashboard.dart';
import '../../widgets/login_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream:FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder:(context,snapshot){
       if(snapshot.hasData){
         return Dashboard(name:userNameController.text);
       }else if(snapshot.connectionState==ConnectionState.waiting){
         return CircularProgressIndicator();
       }else{
         return LoginWidget();
       }
        } );
  }
}
