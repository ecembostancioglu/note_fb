import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  late String title;
  late String desc;
  AuthService authService=AuthService();


  void add()async{
      CollectionReference ref=FirebaseFirestore.instance
          .collection('Users')
          .doc(authService.firebaseAuth.currentUser!.uid)
          .collection('Notes');

    var data={
      'title':title,
      'description':desc,
      'created':DateTime.now(),
    };

    ref.add(data);
    Navigator.pop(context);

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pop();},
                        child: Icon(Icons.arrow_back_ios)),
                    ElevatedButton(onPressed: add,
                         child: Text('Save'))
                  ],
                ),
                Form(
                  child:Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText:'Title',
                              prefixIcon: Icon(Icons.note_add)),
                          onChanged: (val){
                            title=val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration:  InputDecoration(
                              hintText:'Note Description',
                              prefixIcon: Icon(Icons.description)),
                          onChanged: (val){
                            desc=val;
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

    );
  }
}
