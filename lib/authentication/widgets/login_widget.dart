import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final AuthService _authService=AuthService();

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();


  @override
  void dispose() {
   emailController.dispose();
   passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction:TextInputAction.next,
              decoration:const InputDecoration(
                  labelText: 'Email'
              ),
            ),
            SizedBox(height: 40.h),
            TextField(
              controller: passwordController,
              cursorColor: Colors.white,
              obscureText: true,
              textInputAction:TextInputAction.done,
              decoration:const InputDecoration(
                  labelText: 'Password'
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize:const Size.fromHeight(50),
                    elevation: 6,
                  primary: Colors.orange
                ),
                icon:const Icon(Icons.lock_open,size: 30),
                onPressed:()async{
                  await Provider.of<AuthService>(context,listen: false).signInAnonymously();
                },
                label:const Text('Sign In',
                    style: TextStyle(fontSize: 24))),
            SizedBox(height: 20.h),
            Text('OR',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize:const Size.fromHeight(50),
                  elevation: 6,
                  primary: Colors.lightBlueAccent
                ),
                icon:Image.asset('assets/images/google.png',height: 30),
                onPressed:()async{
                await Provider.of<AuthService>(context,listen: false).signInwithGoogle();
                },
                label:Text('Sign In with Google',
                    style: TextStyle(fontSize: 24,color: Colors.black54))),
          ],
        ),
      ),
    );
  }
}