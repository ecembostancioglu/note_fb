import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppConstants{
  static const TR_LOCALE=Locale("tr","TR");
  static const EN_LOCALE=Locale("en","US");
  static const LANG_PATH='assets/lang';
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
  const Color(0xffF2D7D9),
  const Color(0xffD3CEDF),
  const Color(0xff9CB4CC),
  const Color(0xffE4BAD4),
  const Color(0xffDFE8CC),
  const Color(0xffC9E4C5),
  const Color(0xffEBD8C3),
  const Color(0xffF5C6AA),
];

const Color errorBackground= Color(0xFFFE4A49);
const Color iconForeground=Color(0xFFFFFFFF);
const Color buttonColor=Color(0xff645CAA);
const Color navBarColor=Color(0xffEBC7E8);
const Color avatarBgColor=Color(0xffc2c2c2);
const BorderRadius borderRad= BorderRadius.all(Radius.circular(20));