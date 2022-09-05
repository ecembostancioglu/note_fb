import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserDatabase{

  Future<void> addGoogleUsertoFirestore (GoogleSignInAccount auth)async{
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.email)
        .set({'email':auth.email,
      'userUid':auth.id,
      'userName':auth.displayName});

  }
}