import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_fb/notes/database/repository/note_database.dart';
import 'package:todo_fb/notes/domain/models/image_list.dart';
import '../../../authentication/service/auth_service.dart';
import '../../../constants/app_constants.dart';
import '../../database/provider/image_provider.dart';
import '../../widgets/delete_notes.dart';
import '../../widgets/sign_out.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  NoteDatabase noteDatabase=NoteDatabase();
  AuthService authService=AuthService();
  List<String> langs=['English','Turkish'];
  String? dropdownvalue='English';
  final _globalKey=GlobalKey<FormState>();
  SharedPreferences? sharedPreferences;
  Uint8List? imageBytes;

  @override
  void initState() {
    Provider.of<UploadImageProvider>(context, listen: false).base64ToImage();
    super.initState();
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
                GestureDetector(
                  onTap: (){
                    Provider.of<UploadImageProvider>(context, listen: false).pickImage(context);
                    Uint8List? imageBytes=Provider.of<UploadImageProvider>(context, listen: false).base64ToImage();
                    ImagesList images=ImagesList(
                        imageBytes: imageBytes!,
                        email: FirebaseAuth.instance.currentUser!.email!);
                         if(images != null)
                        {
                           Provider.of<UploadImageProvider>(context,listen: false).addImage(images);
                        }

                  },
                  child: Consumer<UploadImageProvider>(
                      builder: (context,state,child)
                      =>state.profileImage !=null
                          ? CircleAvatar(
                        backgroundColor: state.profileImage ==ConnectionState.waiting
                            ? Colors.red
                            : Colors.blue,
                        backgroundImage: MemoryImage(state.profileImage!),
                        radius: 100,
                      )
                          : CircleAvatar(
                            child: Text('Upload Image'),
                            backgroundColor:Colors.grey.shade600,
                            radius:100,
                      )
                  ),
                ),
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
                          controller: userNameController,
                          onChanged: (displayName){
                            setState(() {
                              displayName=userNameController.text;
                            });
                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed:(){
                                  Provider.of<AuthService>(context,listen: false).updateName();
                                },
                                icon:const Icon(Icons.change_circle_outlined,
                                    color: buttonColor),
                              ),
                              border:const OutlineInputBorder(
                                  borderRadius:borderRad)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DeleteAllNotes(noteDatabase: noteDatabase, isDeleted: false),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Change Language'),
                      DropdownButton<String>(
                          value: dropdownvalue,
                          borderRadius: borderRad,
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
                SignOutWidget()
              ],
            ),
          ),
        )
    );

  }
}
