import 'package:flutter/material.dart';
import 'package:todo_fb/authentication/widgets/register_form.dart';
import 'package:todo_fb/authentication/widgets/sign_in_form.dart';
import '../../constants/app_constants.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final FormStatus _formStatus=FormStatus.signIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: _formStatus==FormStatus.signIn
          ? BuildSignInForm()
          : BuildRegisterForm()),
    );
  }



}