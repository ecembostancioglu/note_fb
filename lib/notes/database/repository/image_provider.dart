import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageProvider with ChangeNotifier{
  String imageKey = 'IMG_KEY';
  SharedPreferences? sharedPreferences;

  void imageToBase64(Uint8List imageBytes) {
    sharedPreferences!.setString(imageKey,base64.encode(imageBytes));
  }

  Uint8List base64ToImage(){
    var data = sharedPreferences!.getString(imageKey);
    return base64.decode(data!);
  }

}