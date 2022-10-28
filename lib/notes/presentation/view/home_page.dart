import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/database/repository/note_database.dart';
import 'package:todo_fb/notes/domain/models/auth_user.dart';
import '../../widgets/note_view.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AuthService authService=AuthService();
  String query='';
  NoteDatabase noteDatabase=NoteDatabase();
  AuthUser? authUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:const EdgeInsets.all(20),
                child: Text('Welcome ${authUser?.userName ?? ''}',
                    style: TextStyle(fontSize: 21.sp)),),
              Padding(
                padding:const EdgeInsets.all(12.0),
                child: TextField(
                  controller: searchController,
                  onChanged:(textEntered){
                    setState(() {
                     query=textEntered;
                    });
                  },
                  decoration:const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:borderRad
                      )
                  ),
                ),
              ),
              Flexible(
                  child:StreamBuilder<QuerySnapshot?>(
                   stream:firebaseFirestore
                       .collection('Users')
                       .doc(FirebaseAuth.instance.currentUser!.email)
                       .collection('Notes')
                       .orderBy('created').snapshots(),
                      builder:(context,snapshot) {
                     if (!snapshot.hasData) {
                     return const Center(
                       child: CircularProgressIndicator());
                     }
                     else {
                     if (snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) =>
                      element['title'].toString().toLowerCase()
                      .contains(query.toLowerCase())).isEmpty) {
                       return const Center(
                          child: Text(AppConstants.noData),);
                        }
                        return ListView(
                         children: [
                           ...snapshot.data!.docs
                               .where((QueryDocumentSnapshot<Object?> element)
                           => element['title'].toString().toLowerCase()
                               .contains(query.toLowerCase()))
                               .map((QueryDocumentSnapshot<Object?> data) {
                             return GestureDetector(
                                 onTap: (){
                                   showDialog(context: context, builder: (context){
                                     return AlertDialog(
                                       title:Text(titleCtr.text),
                                       elevation: 10,
                                       actions: [
                                         Text(titleCtr.text),
                                       ],
                                       shape: const RoundedRectangleBorder(borderRadius:borderRad),
                                     );
                                   });
                                 },
                                 child: NoteView(data: data));
                           })
                         ],
                       );
                  }}
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
