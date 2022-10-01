import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageProvider with ChangeNotifier{
  String imageKey = 'IMG_KEY';
  SharedPreferences? sharedPreferences;
}