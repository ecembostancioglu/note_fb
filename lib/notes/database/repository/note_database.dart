import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_fb/constants/app_constants.dart';

final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
final String? firebaseAuthDoc=FirebaseAuth.instance.currentUser!.email;

class NoteDatabase{

  static String? id;

  Future<void> addNote(String title, String description,DateTime created)async{
    DocumentReference documentReference=_firebaseFirestore
        .collection(AppConstants.referencePath)
        .doc(firebaseAuthDoc)
        .collection(AppConstants.collectionPath).doc(id);

    Map<String,dynamic> data=<String,dynamic>{
      'title':title,
      'description':description,
      'created':created,
    };

    await documentReference.set(data).whenComplete(() =>
        print('Note inserted to the database')).catchError((e)=>print(e));

  }
  
   Future<void> deleteNote({required String id})async{
    DocumentReference documentReference=_firebaseFirestore
        .collection(AppConstants.referencePath)
        .doc(firebaseAuthDoc)
        .collection(AppConstants.collectionPath)
        .doc(id);

    await documentReference.delete().whenComplete(() =>
        print('Note deleted from the database')).catchError((e)=>print(e));
  }

  Future<void> deleteAllNotes()async{
    CollectionReference coll=_firebaseFirestore
        .collection(AppConstants.referencePath)
        .doc(firebaseAuthDoc)
        .collection(AppConstants.collectionPath);

    final futureQuery= coll.get();
    await futureQuery.then((value) => value.docs.forEach((element) {
      element.reference.delete();
    }));
  }

  Future<void> update(Map<String,Object?>data)async{
    return await FirebaseFirestore.instance
        .collection(AppConstants.referencePath)
        .doc(firebaseAuthDoc).update(data);

  }

}