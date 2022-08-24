import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../notes/presentation/view/home_page.dart';
import '../../widgets/login_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder:(context,snapshot){
       if(snapshot.hasData){
         return HomePage();
       }else if(snapshot.connectionState==ConnectionState.waiting){
         return CircularProgressIndicator();
       }else{
         return LoginWidget();
       }
        } );
  }
}

