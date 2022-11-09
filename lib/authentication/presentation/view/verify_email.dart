import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/notes/presentation/view/dashboard.dart';

import '../../../constants/app_constants.dart';

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
  String email=FirebaseAuth.instance.currentUser!.email.toString();


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
    if(isEmailVerified)
      timer?.cancel();
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Padding(
               padding: EdgeInsets.only(top: 80.h),
               child: Image.asset('assets/images/verify.png'),
             ),
             Text('Verify Email',
               style:TextStyle(
                   fontSize: 24.sp,
                   fontWeight: FontWeight.bold),),
           Text('An Email has been sent to your email address'),
           Text(email,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16.sp),),
           Text('\nPlease click on that link to verify your email address.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    icon: Icon(Icons.mail),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(buttonColor)
                    ),
                    onPressed:canResendEmail
                        ? sendVerificationEmail
                        : null,
                    label: Text('Resent Email')),
                ElevatedButton.icon(
                    icon: Icon(Icons.logout),
                    onPressed:(){
                      Provider.of<AuthService>(context,listen: false).signOut();
                      Navigator.of(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(errorBackground),

                    ),
                    label: Text('Cancel'))
              ],
            )
          ],
      ),
        );


}
