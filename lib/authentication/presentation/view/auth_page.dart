import 'package:flutter/material.dart';
import '../../widgets/login_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWidget(),
    );
  }
}

