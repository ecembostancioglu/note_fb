import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/notes/database/repository/note_database.dart';
import 'package:todo_fb/notes/database/repository/user_database.dart';
import 'package:todo_fb/notes/domain/models/auth_user.dart';
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
  UploadImageProvider uploadImageProvider=UploadImageProvider();
  XFile? imagem;
  UserDatabase userDatabase=UserDatabase();
  AuthUser? authUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,
        body:SafeArea(
          child: SizedBox(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Column(
                  children: [
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            if(imagem == null){
                              uploadImageProvider.getImage();
                            }
                            else{
                              uploadImageProvider.uploadImagetoStorage(imagem!);
                              print('===> ${imagem!.path}');
                            }
                          });

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: imagem==null
                            ? NetworkImage('https://picsum.photos/250?image=9')
                          //  : File(imagem!.path) as ImageProvider,
                            : Image.file(File(imagem!.path)) as ImageProvider,
                          ),
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Change your name'),
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
