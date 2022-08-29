import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser{
  String uid;
  String userName;
  String email;
  Timestamp accountCreated;

  OurUser({
    required this.uid,
    required this.userName,
    required this.email,
    required this.accountCreated});
}