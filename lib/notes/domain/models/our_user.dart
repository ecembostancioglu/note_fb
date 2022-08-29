import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser{
  String uid;
  String userName;
  String email;

  OurUser({
    required this.uid,
    required this.userName,
    required this.email});
}