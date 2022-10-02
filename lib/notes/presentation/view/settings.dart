import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_fb/notes/database/repository/note_database.dart';
import 'package:todo_fb/notes/domain/models/image_byte.dart';
import '../../../authentication/service/auth_service.dart';
import '../../../constants/app_constants.dart';
import '../../database/repository/image_provider.dart';
import '../../widgets/sign_out.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  NoteDatabase noteDatabase=NoteDatabase();
  AuthService authService=AuthService();
  bool _isDeleted=false;
  List<String> langs=['English','Turkish'];
  String? dropdownvalue='English';
  final _globalKey=GlobalKey<FormState>();
  SharedPreferences? sharedPreferences;
//  ImageByte imageUpload;

  @override
  void initState() {
    super.initState();
    Provider.of<UploadImageProvider>(context,listen:false)
        .initSharedPreferences();
  }


  Future update(){
    Map<String,dynamic> data=<String,dynamic>{
      'userName':userNameController.text
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
                GestureDetector(
                  onTap: (){
                    setState(() {
                      Provider.of<UploadImageProvider>(context, listen: false).pickImage(context);
                    });
                  },
                  child: Consumer<UploadImageProvider>(
                    builder: (context,state,child)
                    =>state.profileImage !=null
                        ? CircleAvatar(
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
                                onPressed:update,
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
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delete all notes'),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:MaterialStateProperty
                                  .all(buttonColor)),
                          onPressed:(){
                            noteDatabase.deleteAllNotes();
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

class UserAvatar extends StatelessWidget {
   UserAvatar({
    Key? key,
    required this.imageUpload,
  }) : super(key: key);

   ImageByte imageUpload;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.blue,
      radius: 100,
      backgroundImage: MemoryImage(imageUpload.imageBytes),
    );
  }
}
