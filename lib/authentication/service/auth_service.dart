import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/data/repository/user_database.dart';
import 'package:todo_fb/notes/domain/models/auth_user.dart';

class AuthService extends ChangeNotifier{
  final firebaseAuth=FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  UserDatabase userDatabase=UserDatabase();
  late AuthUser authUser;

  Future<User?> createUserWithEmailandPassword(String name,String email,String password)async{
    final user=await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password);
    await FirebaseFirestore.instance
        .collection(AppConstants.referencePath)
        .doc(user.user!.email)
        .set({
      'email':user.user!.email,
    'userUid':user.user!.uid,
    'userName':user.user!.displayName});
    authUser.email=user.user!.email!;
    authUser.userName=user.user!.displayName!;
    authUser.authUserId=user.user!.uid;
      notifyListeners();
    return user.user;
  }

  Future<User?> signInWithEmailandPassword(String email,String password)async{
    final userCredential=await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    notifyListeners();
    return userCredential.user;
  }


  Future<void> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      if(googleSignInAccount !=null){
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        userDatabase.addGoogleUsertoFirestore(googleSignInAccount);
        await firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    }
    notifyListeners();
  }

  Future<void> signOut() async{
    await firebaseAuth.signOut();
    await _googleSignIn.signOut();
    notifyListeners();
  }
}