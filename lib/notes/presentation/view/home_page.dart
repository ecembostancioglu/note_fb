import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/authentication/widgets/login_widget.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/data/repository/note_database.dart';
import '../../widgets/add_note.dart';
import '../../widgets/note_view.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key,required this.name}) : super(key: key);

  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  NoteDatabase noteDatabase=NoteDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon:const Icon(Icons.logout),
            onPressed: ()async{
              await Provider.of<AuthService>(context,listen: false).signOut().then((_)
              {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginWidget(),
                    ),
                        (Route route) => false);
              });
            },
          )
        ],
      ),
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Padding(
              padding:const EdgeInsets.all(20),
             child: Text('Welcome ${widget.name}'),),
             Padding(
                padding: EdgeInsets.all(12.0),
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
                child: FutureBuilder<QuerySnapshot>(
                  future: noteDatabase.getNoteList(
                      AppConstants.referencePath,
                      AppConstants.collectionPath),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                     return ListView.builder(
                       itemCount: snapshot.data!.docs.length,
                         itemBuilder:(context,index){
                         var data=snapshot.data!.docs[index];
                           return NoteView(
                               data:data,
                               index:index);
                         });
                    }else{
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                  },
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>AddNote(),)
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),


      ),
    );
  }
}


