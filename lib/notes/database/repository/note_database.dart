import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_fb/constants/app_constants.dart';

class NoteDatabase {

  static String? id;

  Stream<QuerySnapshot> readNotes(){
    Query notesCollection =firebaseFirestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('Notes')
        .orderBy('created');

    return notesCollection.snapshots();
  }


  Future<void> addNote(String title, String description,DateTime created,String? finishDate)async{
    DocumentReference documentReference=firebaseFirestore
        .collection(AppConstants.referencePath)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.collectionPath).doc(id);

    Map<String,dynamic> data=<String,dynamic>{
      'title':title,
      'description':description,
      'created':created,
      'finishDate':finishDate,
    };

    await documentReference.set(data).whenComplete(() =>
        print('Note inserted to the database')).catchError((e)=>print(e));

  }
  
   Future<void> deleteNote({required String id})async{
    DocumentReference documentReference=firebaseFirestore
        .collection(AppConstants.referencePath)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.collectionPath)
        .doc(id);

    await documentReference.delete().whenComplete(() =>
        print('Note deleted from the database')).catchError((e)=>print(e));
  }

  Future<void> deleteAllNotes()async{
    CollectionReference coll=firebaseFirestore
        .collection(AppConstants.referencePath)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.collectionPath);

    final futureQuery= coll.get();
    await futureQuery.then((value) => value.docs.forEach((element) {
      element.reference.delete();
    }));
  }

  Future updateNote(String? title,String? description,DateTime? created,String? finishDate,String noteId){
    Map<String,dynamic> data=<String,dynamic>{
      'title':title,
      'description':description,
      'created':created,
      'finishDate':finishDate,
    };
    return FirebaseFirestore.instance
        .collection(AppConstants.referencePath)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppConstants.collectionPath).doc(noteId).update(data);

  }


}