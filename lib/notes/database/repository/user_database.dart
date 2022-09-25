import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_fb/constants/app_constants.dart';

class UserDatabase{

  Future<void> addGoogleUsertoFirestore (GoogleSignInAccount auth)async{
    await FirebaseFirestore.instance
        .collection(AppConstants.referencePath)
        .doc(auth.email)
        .set({'email':auth.email,
      'userUid':auth.id,
      'userName':auth.displayName});

  }
}