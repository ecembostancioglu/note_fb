import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppConstants{
  static const String collectionPath='Notes';
  static const String referencePath='Users';
  static const double borderRadius=20.0;
  static const String noData='Something is missing here..';
  static const String created='created';
  static const String flushBar='The note was deleted.';
  static const String title1='Take Notes';
  static const String title2='Search Everything';
  static const String title3='Beautiful. Easy.';
  static const String description1='Take notes and capture ideas \nat a moment notice...';
  static const String description2='Search and find everything...';
  static const String description3='If you join us, click the button...';


}

enum FormStatus {signIn,register}

TextEditingController signInEmailController=TextEditingController();
TextEditingController registeremailController=TextEditingController();
TextEditingController signInPasswordController=TextEditingController();
TextEditingController registerPasswordController=TextEditingController();
TextEditingController controlPasswordController=TextEditingController();
TextEditingController userNameController=TextEditingController();
TextEditingController searchController=TextEditingController();
TextEditingController titleCtr=TextEditingController();
TextEditingController descCtr=TextEditingController();
TextEditingController updateTitleCtr=TextEditingController();
TextEditingController updateDescCtr=TextEditingController();
final firebaseAuth=FirebaseAuth.instance;
final FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

final colors=[
  const Color(0xff57699a),
  const Color(0xff1349a0),
  const Color(0xff55b3e5),
  const Color(0xfff7ea84),
  const Color(0xff2d9df8),
  const Color(0xffb6deec),
  const Color(0xfff6c133),
  const Color(0xff707D9D),
];

const Color errorBackground= Color(0xFFEE6C4D);
const Color iconForeground=Color(0xFFFFFFFF);
const Color buttonColor=Color(0xff1349a0);
const Color navBarColor=Color(0xff1349a0);
const Color floatingButtonColor=Color(0xfff6c133);
const Color avatarBgColor=Color(0xffc2c2c2);
const BorderRadius borderRad= BorderRadius.all(Radius.circular(20));