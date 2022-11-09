import 'dart:io' as i;
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_fb/constants/locale_constants.dart';
import 'package:todo_fb/notes/database/repository/note_database.dart';
import 'package:todo_fb/notes/database/repository/user_database.dart';
import 'package:todo_fb/notes/domain/models/auth_user.dart';
import '../../../authentication/service/auth_service.dart';
import '../../../constants/app_constants.dart';
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
  UserDatabase userDatabase=UserDatabase();
  AuthUser? authUser;
  String imageUrl='';


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
                        onTap: ()async{
                         ImagePicker imagePicker=ImagePicker();
                         XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
                         print('${file?.path}');

                         if(file==null) return;

                         String uniqueFileName=FirebaseAuth.instance.currentUser!.email.toString();

                         Reference reference=FirebaseStorage.instance.ref();
                         Reference refImages=reference.child('photos');

                         Reference refImagestoUpload=refImages.child(uniqueFileName);

                         try{
                           await refImagestoUpload.putFile(File(file.path));
                           imageUrl=await refImagestoUpload.getDownloadURL();
                           authUser?.photoUrl=imageUrl;
                         }catch(error){
                           print(error);
                         }

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 90.r,
                              backgroundColor: avatarBgColor,
                              foregroundColor: avatarBgColor,
                              child: Image.asset('assets/images/image.png'))
                        )
                    ),
                    Text(LocaleConstants.loginwithGoogle.myLocale),
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
                                     if(dropdownvalue=='English'){
                                       context.setLocale(LocaleConstants.EN_LOCALE);
                                     }else {
                                       context.setLocale(LocaleConstants.TR_LOCALE);
                                     }
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
