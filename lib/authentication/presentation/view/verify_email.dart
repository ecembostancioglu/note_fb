import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/notes/presentation/view/dashboard.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

 // final String name;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {

  bool isEmailVerified=false;
  bool canResendEmail=false;
  Timer? timer;
  @override
  void initState() {
    isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();

      timer= Timer.periodic(
          const Duration(seconds: 3), (_)=>
         checkEmailVerified());
    }
    super.initState();
  }

  @override
  void dispose() {
     timer!.cancel();
    super.dispose();
  }

  Future checkEmailVerified()async{

    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail()async{
    try{
      final user=FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail=false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail=true);
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context)
   => isEmailVerified
        ? Dashboard()
        : Scaffold(
          body: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text('A verification email has been sent to your email'),
            ElevatedButton.icon(
                icon: Icon(Icons.mail),
                onPressed:canResendEmail
                    ? sendVerificationEmail
                    : null,
                label: Text('Resent Email')),
            ElevatedButton(
                onPressed:(){
                  Provider.of<AuthService>(context,listen: false).signOut();
                  Navigator.of(context);
                },
                child: Text('Cancel'))
          ],
      ),
   ),
        );


}
