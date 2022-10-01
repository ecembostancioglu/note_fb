import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../authentication/presentation/view/auth_page.dart';
import '../../authentication/service/auth_service.dart';
import '../../constants/app_constants.dart';

class SignOutWidget extends StatefulWidget {
  const SignOutWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignOutWidget> createState() => _SignOutWidgetState();
}

class _SignOutWidgetState extends State<SignOutWidget> {

  AuthService authService=AuthService();

     signOut(){
     Provider.of<AuthService>(context,listen: false).signOut();
      Navigator.pushReplacement(
                 context, MaterialPageRoute(
                 builder: (context)=> AuthPage()));



  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sign Out'),
            IconButton(
              icon:const Icon(Icons.logout,color: buttonColor),
              onPressed:signOut,
            ),
          ],
        )
    );
  }
}