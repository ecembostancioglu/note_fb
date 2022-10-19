import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as i;

class UploadImageProvider{

  String? _photoUrl='https://picsum.photos/250?image=9';
  String? uploadedImageUrl;
  FirebaseStorage _storage=FirebaseStorage.instance;

  XFile? _images;
  final ImagePicker picker=ImagePicker();

  Future getImage() async{
    final pickedFile=await ImagePicker().pickImage(source: ImageSource.gallery);

      if(pickedFile != null){
        _images=XFile(pickedFile.path);
      }else{
        print('No image selected.');
      }

    if(pickedFile!=null){
      _photoUrl = await uploadImagetoStorage(_images!);
    }
  }

  Future<String> uploadImagetoStorage(XFile imageFile)async{
    String path='${FirebaseAuth.instance.currentUser!.email}';

    TaskSnapshot uploadTask =await _storage.ref()
        .child('photos')
        .child(path)
        .putFile(i.File(imageFile.path));

    uploadedImageUrl=await uploadTask.ref.getDownloadURL();
    print('===> $uploadedImageUrl}');

    return uploadedImageUrl!;

  }





}

