import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_fb/notes/data/repository/note_database.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  NoteDatabase noteDatabase=NoteDatabase();
  bool _isDeleted=false;
  List<String> langs=['English','Turkish'];
  String? dropdownvalue='English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Delete all notes'),
                    ElevatedButton(
                        onPressed:(){
                          noteDatabase.deleteNotes();
                        setState(() {
                          _isDeleted=true;
                        });
                        },
                        child:_isDeleted==false
                            ? Text('DELETE')
                            : Icon(Icons.check)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Change Language'),
                    DropdownButton<String>(
                      value: dropdownvalue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                        elevation:10,
                        items: langs.map((langs)
                        =>DropdownMenuItem<String>(
                          value:langs,
                            child: Text(langs))).toList(),
                           onChanged:(newItem)=>
                            setState(() {
                              dropdownvalue=newItem.toString();
                            })
                    ),
              ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
