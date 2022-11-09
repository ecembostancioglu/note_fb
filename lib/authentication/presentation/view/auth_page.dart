import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/notes/presentation/view/dashboard.dart';
import '../../widgets/login_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final auth=Provider.of<AuthService>(context,listen: false);

    return StreamBuilder<User?>(
        stream:auth.authStatus(),
        builder:(context,snapshot){
       if(snapshot.hasData){
         return Dashboard();
       }else if(snapshot.connectionState==ConnectionState.waiting){
         return const CircularProgressIndicator();
       }else{
         return LoginWidget();
       }
        } );
  }
}
