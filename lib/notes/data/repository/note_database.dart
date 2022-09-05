import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/models/note.dart';

class NoteDatabase{
  FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;

  //GET NOTE LIST FROM FB
  Future<QuerySnapshot> getNoteList(String referencePath,String collectionPath){
    return _firebaseFirestore
        .collection(referencePath)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(collectionPath).get();
  }

  //ADD NEW NOTE AND UPDATE

  Future<void> setNote({String? referencePath,String? collectionPath, Map<String, dynamic>? noteAsMap})async{
    await _firebaseFirestore
        .collection(referencePath!)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(collectionPath!)
        .doc(Note.fromMap(noteAsMap!).title)
        .set(noteAsMap);
  }

  //DELETE NOTE
  Future<void> deleteDocument(String referencePath, String collectionPath, String id) async{
    await _firebaseFirestore
        .collection(referencePath)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(collectionPath)
        .doc(id).delete();
  }

}