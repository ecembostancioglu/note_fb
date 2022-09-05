import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../presentation/view/verify_email.dart';
import '../service/auth_service.dart';
import 'error_widget.dart';

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
                  builder: (context)=>VerifyEmailPage(name:userNameController.text)));
        });
      }
    }on FirebaseAuthException catch (error){
      displayErrorToast(context,error.message!);
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