import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/constants/app_constants.dart';
import 'package:todo_fb/notes/data/repository/note_database.dart';
import '../../../authentication/presentation/view/auth_page.dart';
import '../../../authentication/service/auth_service.dart';

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
  final _globalKey=GlobalKey<FormState>();

  TextEditingController nameController=TextEditingController();

  Future update(){
    Map<String,dynamic> data=<String,dynamic>{
      'userName':nameController.text
    };
   return FirebaseFirestore.instance
        .collection(AppConstants.referencePath)
        .doc(FirebaseAuth.instance.currentUser!.email).update(data);

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      body:SafeArea(
        child: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Change your name'),
                    SizedBox(width: 40),
                    Expanded(
                      child: TextFormField(
                        key: _globalKey,
                        controller: nameController,
                        onChanged: (displayName){
                          setState(() {
                             displayName=nameController.text;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed:update,
                            icon: Icon(Icons.change_circle_outlined),
                          ),
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)))
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delete all notes'),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:MaterialStateProperty
                              .all(const Color(0xff645CAA))),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sign Out'),
                    IconButton(
                      icon:const Icon(Icons.logout),
                      onPressed: ()async{
                        await Provider.of<AuthService>(context,listen: false).signOut().then((_)
                        {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(
                              builder: (context)=>AuthPage()));
                        });
                      },
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
