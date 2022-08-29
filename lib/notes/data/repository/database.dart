import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> addUsertoFirestore(User? currentUser)async{
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .set({'email':currentUser.email,
      'userUid':currentUser.uid,
      'userName':currentUser.displayName});

}

Future<void> addGoogleUsertoFirestore (GoogleSignInAccount auth)async{
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(auth.id)
      .set({'email':auth.email,
    'userUid':auth.id,
    'userName':auth.displayName});

}