import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../service/auth_service.dart';
import 'register_form.dart';

class BuildSignInForm extends StatefulWidget {
  const BuildSignInForm({Key? key}) : super(key: key);

  @override
  State<BuildSignInForm> createState() => _BuildSignInFormState();
}

class _BuildSignInFormState extends State<BuildSignInForm> {

  bool _signInObscureText=true;
  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign In'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator:(email) =>
                     email != null && !EmailValidator.validate(email)
                      ? 'enter a valid email'
                      : null,
                  controller: signInEmailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  textInputAction:TextInputAction.next,
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail),
                      labelText: 'Email'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator:(value){
                  if(value != null && value.length < 7){
                    return 'Enter min. 7 characters';
                  }else{
                    return null;
                  }
                },
                  controller: signInPasswordController,
                  cursorColor: Colors.white,
                  obscureText: _signInObscureText,
                  textInputAction:TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
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
                    final isValidForm=formKey.currentState!.validate();
                    if(isValidForm){
                      await Provider.of<AuthService>(context,listen: false)
                          .signInWithEmailandPassword(
                          signInEmailController.text,
                          signInPasswordController.text);
                    }

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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BuildRegisterForm()));
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
          ),),
      ),
    );
  }
}
