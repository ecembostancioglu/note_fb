import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_fb/authentication/service/auth_service.dart';
import 'package:todo_fb/authentication/widgets/login_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AuthService auth=AuthService();
  List<Note> searchNotes=allNotes;

  void searchNote(String query){
    final suggestions=allNotes.where((note){
      final noteText=note.title.toLowerCase();
      final input=query.toLowerCase();

      return noteText.contains(input);
    }).toList();

    setState(() {
      searchNotes=suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: (){
              auth.signOutFromGoogle();
              auth.signOut();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>LoginWidget()));
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
            const Padding(
              padding:EdgeInsets.all(20),
             child: Text('WELCOME'),),
             Padding(
                padding: EdgeInsets.all(12.0),
                child: TextField(
                  onChanged:searchNote,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    )
                  ),

                ),
              ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                itemCount: searchNotes.length,
                  itemBuilder: (context,index){
                return ListTile(
                  leading: Text('${searchNotes[index].id}'),
                  title: Text(searchNotes[index].title),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class Note{
  final int id;
  final String title;

  Note({required this.id,required this.title});
}

  List<Note> allNotes=[
  Note(id: 1, title: 'One'),
  Note(id: 2, title: 'Two'),
  Note(id: 3, title: 'Three'),
  Note(id: 4, title: 'Four'),
  Note(id: 5, title: 'Five'),
  Note(id: 6, title: 'Six'),
];