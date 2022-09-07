import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_fb/constants/app_constants.dart';
import '../../domain/models/note.dart';

class NoteDatabase{
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;

  //GET NOTE LIST FROM FB
 // Future<QuerySnapshot> getNoteList(String referencePath,String collectionPath){
  //     return _firebaseFirestore
  //         .collection(referencePath)
  //         .doc(FirebaseAuth.instance.currentUser!.email)
  //         .collection(collectionPath).get();
  //   }

  Stream<QuerySnapshot> readNotes(){
    CollectionReference notesCollection =_firebaseFirestore
        .collection(AppConstants.referencePath)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.collectionPath);

    return notesCollection.snapshots();
  }

  Future<void> setNote(String referencePath,String collectionPath, Map<String, dynamic> noteAsMap)async{
    await _firebaseFirestore
        .collection(referencePath)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(collectionPath)
        .doc(Note.fromMap(noteAsMap).title)
        .set(noteAsMap);
  }
  
   Future<void> deleteNote({required String id})async{
    DocumentReference documentReference=_firebaseFirestore
        .collection(AppConstants.referencePath)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.collectionPath)
        .doc(id);

    await documentReference.delete().whenComplete(() =>
        print('Note deleted from the database')).catchError((e)=>print(e));
  }



}