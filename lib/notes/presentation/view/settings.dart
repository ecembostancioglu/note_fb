import 'dart:io' as i;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_fb/notes/database/repository/note_database.dart';
import 'package:todo_fb/notes/domain/models/auth_user.dart';
import '../../../authentication/service/auth_service.dart';
import '../../../constants/app_constants.dart';
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
  String? _photoUrl='https://picsum.photos/250?image=9';
  String? uploadedImageUrl;


  XFile? _images;
  final picker=ImagePicker();

  Future getImage() async{
    final pickedFile=await ImagePicker().pickImage(source: ImageSource.gallery);

  setState(() {
    if(pickedFile != null){
      _images=XFile(pickedFile.path);
    }else{
      print('No image selected.');
    }
  });
        if(pickedFile!=null){
          _photoUrl = await uploadImagetoStorage(_images!);
        }
  }

  Future<String> uploadImagetoStorage(XFile imageFile)async{
    String path='${FirebaseAuth.instance.currentUser!.email}';

  TaskSnapshot uploadTask =await FirebaseStorage.instance.ref().child('photos').child(path).putFile(i.File(_images!.path));

  uploadedImageUrl=await uploadTask.ref.getDownloadURL();
  print('=================================> $uploadedImageUrl}');

    AuthUser user=AuthUser(
        email: signInEmailController.text,
        userName: userNameController.text,
        photoUrl: uploadedImageUrl!);

  return uploadedImageUrl!;

  }




  @override
  Widget build(BuildContext context) {

    AuthUser user=AuthUser(
        email: signInEmailController.text,
        userName: userNameController.text,
        photoUrl: uploadedImageUrl.toString());

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
                    getImage();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: _images == null
                        ? Icon(Icons.account_circle,size: 100)
                        : Image.network('${user.photoUrl}',height: 100,width: 100)
                  )
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
