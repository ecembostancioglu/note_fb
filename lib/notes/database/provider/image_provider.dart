import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_fb/notes/domain/models/image_list.dart';

class UploadImageProvider with ChangeNotifier{
  String imageKey = 'IMG_KEY';
  List<ImagesList> images=[];
  SharedPreferences? sharedPreferences;
  Uint8List? imageBytes;
  Uint8List? profileImage;

  void addImage(ImagesList image) {
    images.add(image);
    saveDataToLocalStorage();
    notifyListeners();
  }


  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    notifyListeners();
  }

  void saveDataToLocalStorage() {
    List<String>? spList = images.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences?.setStringList('list',spList);
  }


  Future pickImage(BuildContext context) async {

    XFile? image = await ImagePicker().pickImage(source:ImageSource.gallery);

    if (image != null) {
      imageBytes = await image.readAsBytes();
      imageToBase64(imageBytes!);
      notifyListeners();
      base64ToImage();
      notifyListeners();
    }
  }

  void imageToBase64(Uint8List imageBytes){
    sharedPreferences!.setString(imageKey,base64.encode(imageBytes));
    notifyListeners();
  }

  Uint8List? base64ToImage(){
    var data = sharedPreferences!.getString(imageKey);
    data == null
        ? null
        : profileImage = base64.decode(data);
    return profileImage;
  }

}