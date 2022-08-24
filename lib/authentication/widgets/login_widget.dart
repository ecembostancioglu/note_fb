
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  minimumSize:const Size.fromHeight(50)
              ),
              icon:const Icon(Icons.lock_open,size: 30),
              onPressed: (){},
              label:const Text('Sign In',
                  style: TextStyle(fontSize: 24)))
        ],
      ),
    );
  }
}