import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/authentication/presentation/view/auth_page.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/notes/data/repository/note_database.dart';
import '../../widgets/note_view.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  NoteDatabase noteDatabase=NoteDatabase();

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
                    onChanged:(val){},
                    decoration:const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      )
                    ),
                  ),
                ),
              Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: noteDatabase.readNotes(),
                    builder: (context,snapshot){
                      if(snapshot.hasData || snapshot.data !=null){
                       return ListView.builder(
                         itemCount: snapshot.data?.docs.length,
                           itemBuilder:(context,index){
                           var data=snapshot.data!.docs[index];
                           String id=snapshot.data!.docs[index].id;
                             return NoteView(
                                 id:id,
                                 data:data,
                                 index:index);
                           });
                      }
                      else{
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


