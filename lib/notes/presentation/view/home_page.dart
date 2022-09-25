import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/constants/app_constants.dart';
import '../../database/repository/note_database.dart';
import '../../widgets/note_view.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  NoteDatabase noteDatabase=NoteDatabase();
  AuthService authService=AuthService();
  final TextEditingController _searchController=TextEditingController();
  String query='';


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
                child: Text('Welcome',
                    style: TextStyle(fontSize: 21.sp)),),
              Padding(
                padding:const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _searchController,
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
                  child:
                  StreamBuilder<QuerySnapshot>(
                    stream:noteDatabase.readNotes(),
                    builder: (context,snapshot){
                     if(!snapshot.hasData){
                       return Center(child: CircularProgressIndicator(),);
                     }
                     else{

                       if(snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element)
                       => element['title'].toString().toLowerCase().contains(query.toLowerCase())).isEmpty){
                         return Center(child: Text(AppConstants.noData),);
                       }

                      return ListView(
                        children: [
                          ...snapshot.data!.docs
                          .where((QueryDocumentSnapshot<Object?> element)
                           => element['title'].toString().toLowerCase()
                          .contains(query.toLowerCase()))
                              .map((QueryDocumentSnapshot<Object?> data){
                                      return NoteView(
                                      //    id:id,
                                      //   index:index,
                                         data:data);
                          })
                        ],
                      );
                     }
                    },
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
