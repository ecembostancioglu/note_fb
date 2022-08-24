import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{

  final _firebaseAuth=FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    final userCredentials=await _firebaseAuth.signInAnonymously();
    notifyListeners();
    return userCredentials.user;

  }
}