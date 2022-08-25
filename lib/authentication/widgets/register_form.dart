import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/authentication/widgets/sign_in_form.dart';

import '../../constants/app_constants.dart';
import '../service/auth_service.dart';

class BuildRegisterForm extends StatefulWidget {
  const BuildRegisterForm({Key? key}) : super(key: key);

  @override
  State<BuildRegisterForm> createState() => _BuildRegisterFormState();
}

class _BuildRegisterFormState extends State<BuildRegisterForm> {
  bool _controlObscureText=true;
  bool _obscureText=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Register'),
            TextFormField(
              controller: userNameController,
              cursorColor: Colors.white,
              textInputAction:TextInputAction.next,
              decoration:const InputDecoration(
                  labelText: 'Name'
              ),
            ),
            TextFormField(
              controller: registeremailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.white,
              textInputAction:TextInputAction.next,
              decoration:const InputDecoration(
                  labelText: 'Email'
              ),
            ),
            TextFormField(
              controller: registerPasswordController,
              cursorColor: Colors.white,
              obscureText: _obscureText,
              textInputAction:TextInputAction.done,
              decoration:InputDecoration(
                  labelText: 'Password',
                  suffixIcon:IconButton(
                      onPressed: (){
                        setState(() {
                          _obscureText=!_obscureText;
                        });
                      }, icon: Icon(_obscureText
                      ? Icons.visibility
                      : Icons.visibility_off))
              ),
            ),
            TextFormField(
              controller: controlPasswordController,
              cursorColor: Colors.white,
              obscureText: _controlObscureText,
              textInputAction:TextInputAction.done,
              decoration:InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          _controlObscureText=!_controlObscureText;
                        });
                      },
                      icon: Icon(_controlObscureText
                          ? Icons.visibility
                          : Icons.visibility_off))
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
                  await Provider.of<AuthService>(context,listen: false).signInWithEmailandPassword(
                      signInEmailController.text, signInPasswordController.text);
                },
                label:const Text('Sign Up',
                    style: TextStyle(fontSize: 24))),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BuildSignInForm()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  Text('SIGN IN',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            )
          ],
        ),),
    );
  }
}
