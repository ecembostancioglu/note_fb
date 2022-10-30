import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_fb/notes/database/repository/note_database.dart';
import 'package:todo_fb/notes/database/repository/user_database.dart';
import 'package:todo_fb/notes/domain/models/auth_user.dart';
import '../../../authentication/service/auth_service.dart';
import '../../../constants/app_constants.dart';
import '../../database/provider/image_provider.dart';
import '../../widgets/change_name_dialog.dart';
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
                              uploadImageProvider.getImage();

                              uploadImageProvider.uploadImagetoStorage(imagem!);
                              print('===> ${imagem!.path}');

                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: imagem==null
                            ? Image(
                            height: 150.h,
                            width: 150.h,
                              image: NetworkImage('https://picsum.photos/250?image=9'))
                              : Image.file(File(imagem!.path)),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              authUser?.userName ?? '',
                              style:TextStyle(fontSize: 24.sp)),
                             IconButton(
                              onPressed:(){
                                setState(() {
                                  changeName(context);
                                });
                              },
                              icon:const Icon(
                                  Icons.mode_edit_outline_outlined,
                                  color:buttonColor),
                            ),
                        ],
                      ),
                    ),
                    DeleteAllNotes(noteDatabase: noteDatabase, isDeleted: false),
                    Padding(
                      padding:const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Change Language'),
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
                    const SignOutWidget()
                  ],
                ),
          ),
        )
    );

  }
}
