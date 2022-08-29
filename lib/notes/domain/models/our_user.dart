import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser{
  String uid;
  String userName;
  Timestamp accountCreated;

  OurUser({
    required this.uid,
    required this.userName,
    required this.accountCreated});
}