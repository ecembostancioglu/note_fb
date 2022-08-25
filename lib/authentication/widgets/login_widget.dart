import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../service/auth_service.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  FormStatus _formStatus=FormStatus.signIn;
  TextEditingController signInEmailController=TextEditingController();
  TextEditingController registeremailController=TextEditingController();
  TextEditingController signInPasswordController=TextEditingController();
  TextEditingController registerPasswordController=TextEditingController();
  TextEditingController controlPasswordController=TextEditingController();
  final List<String> errors=['Demo Errors'];
  bool _controlObscureText=true;
  bool _obscureText=true;
  bool _signInObscureText=true;

  @override
  void dispose() {
    signInEmailController.dispose();
    signInPasswordController.dispose();
    controlPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: _formStatus==FormStatus.signIn
          ? buildSignInForm()
          : buildRegisterForm()),
    );
  }

  Widget buildSignInForm(){
    return Padding(
      padding: EdgeInsets.all(20),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign In'),
          SizedBox(height: 20.h),
          TextFormField(
            controller: signInEmailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.white,
            textInputAction:TextInputAction.next,
            decoration:const InputDecoration(
                labelText: 'Email'
            ),
          ),
          SizedBox(height: 20.h),
          TextFormField(
            controller: signInPasswordController,
            cursorColor: Colors.white,
            obscureText: _signInObscureText,
            textInputAction:TextInputAction.done,
            decoration: InputDecoration(
                labelText: 'Password',
              suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _signInObscureText=! _signInObscureText;

                    });
                  },
                  icon:Icon( _signInObscureText
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
                  primary: Colors.lightBlueAccent),
              icon:Image.asset('assets/images/google.png',
                  height: 30,
                  fit: BoxFit.cover),
              onPressed:()async{
                await Provider.of<AuthService>(context,listen: false).signInwithGoogle();
              },
              label:Text('Sign In with Google',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black54))),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: (){
              setState(() {
                _formStatus=FormStatus.register;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?'),
                Text('SIGN UP',style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          )
        ],
      ),);
  }
  Widget buildRegisterForm(){
    return Padding(
      padding: EdgeInsets.all(20),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Register'),
          SizedBox(height: 20.h),
          TextFormField(
            controller: registeremailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.white,
            textInputAction:TextInputAction.next,
            decoration:const InputDecoration(
                labelText: 'Email'
            ),
          ),
          SizedBox(height: 20.h),
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
                  }, icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off))
            ),
          ),
          SizedBox(height: 20.h),
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
              setState(() {
                _formStatus=FormStatus.signIn;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                Text('SIGN IN',style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          )
        ],
      ),);
  }


}