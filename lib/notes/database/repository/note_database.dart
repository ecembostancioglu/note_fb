import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_fb/constants/app_constants.dart';

class NoteDatabase{

  static String? id;

  Future<void> addNote(String title, String description,DateTime created)async{
    DocumentReference documentReference=firebaseFirestore
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
    DocumentReference documentReference=firebaseFirestore
        .collection(AppConstants.referencePath)
        .doc(firebaseAuthDoc)
        .collection(AppConstants.collectionPath)
        .doc(id);

    await documentReference.delete().whenComplete(() =>
        print('Note deleted from the database')).catchError((e)=>print(e));
  }

  Future<void> deleteAllNotes()async{
    CollectionReference coll=firebaseFirestore
        .collection(AppConstants.referencePath)
        .doc(firebaseAuthDoc)
        .collection(AppConstants.collectionPath);

    final futureQuery= coll.get();
    await futureQuery.then((value) => value.docs.forEach((element) {
      element.reference.delete();
    }));
  }

}