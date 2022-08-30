import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../presentation/view/verify_email.dart';
import '../service/auth_service.dart';


class SignUpButton extends StatefulWidget {
  const SignUpButton({
    Key? key,
    required formKey,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {

  void errorWidget(String description,String errorCode){
    MotionToast.error(
      description: Text(description),
      title: Text(errorCode),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.bottom,
      barrierColor: Colors.black.withOpacity(0.3),
      width: 350,
      height:150,
      toastDuration:const Duration(seconds: 3),
    ).show(context);
  }


  Future register()async{
    final isValidForm=widget._formKey.currentState!.validate();
    try{
      if(isValidForm){
        await Provider.of<AuthService>(context,listen: false)
            .createUserWithEmailandPassword(
            userNameController.text,
            registeremailController.text,
            registerPasswordController.text).then((_){
          Navigator.pushReplacement(context,
              MaterialPageRoute(
                  builder: (context)=>VerifyEmailPage()));
        });
      }
    }on FirebaseAuthException catch (error){
      print(error.message);
      errorWidget(error.message!,error.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            minimumSize:const Size.fromHeight(50),
            elevation: 6,
            primary: Colors.orange),
        icon:const Icon(Icons.lock_open,size: 30),
        onPressed:register,
        label:const Text('Sign Up',
            style: TextStyle(fontSize: 24)));
  }
}