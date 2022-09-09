import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_fb/authentication/widgets/sign_in_form.dart';
import '../../constants/app_constants.dart';
import 'sing_up_button.dart';

class BuildRegisterForm extends StatefulWidget {
  const BuildRegisterForm({Key? key}) : super(key: key);

  @override
  State<BuildRegisterForm> createState() => _BuildRegisterFormState();
}

class _BuildRegisterFormState extends State<BuildRegisterForm> {
  bool _controlObscureText=true;
  bool _obscureText=true;
  final _formKey=GlobalKey<FormState>();

  @override
  void initState() {
    registeremailController.clear();
    registerPasswordController.clear();
    controlPasswordController.clear();
    userNameController.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: userNameController,
                  cursorColor: Colors.white,
                  textInputAction:TextInputAction.next,
                  decoration:const InputDecoration(
                      labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon:Icon(Icons.person_rounded)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator:(email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'enter a valid email'
                      : null,
                  controller: registeremailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  textInputAction:TextInputAction.next,
                  decoration:const InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(),
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
                  controller: registerPasswordController,
                  cursorColor: Colors.white,
                  obscureText: _obscureText,
                  textInputAction:TextInputAction.done,
                  decoration:InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator:(value){
                    if(value != null && value.length < 7){
                      return 'Enter min. 7 characters';
                    }else if(value !=registerPasswordController.text){
                      return 'Not Match';
                    }else{
                      return null;
                    }
                  },
                  controller: controlPasswordController,
                  cursorColor: Colors.white,
                  obscureText: _controlObscureText,
                  textInputAction:TextInputAction.done,
                  decoration:InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
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
              ),
              SizedBox(height: 20.h),
              SignUpButton(formKey: _formKey),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>BuildSignInForm()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:const [
                    Text('Already have an account?'),
                    Text('SIGN IN',
                      style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              )
            ],
          ),),
      ),
    );
  }
}

