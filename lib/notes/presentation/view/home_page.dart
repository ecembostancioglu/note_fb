import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/authentication/widgets/login_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: (){
              AuthService _auth=AuthService();
              _auth.signOutFromGoogle();
              FirebaseAuth.instance.signOut();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>LoginWidget()));
            },
          )
        ],
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
