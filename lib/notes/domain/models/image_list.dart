import 'dart:typed_data';

class ImagesList{
  Uint8List imageBytes;
  String email;

  ImagesList({required this.imageBytes,required this.email});

  ImagesList.fromMap(Map map):
        imageBytes = _getImageBinary(map['imageBytes']),
        email = map['email'] as String;

  Map toMap(){
    return{
      'imageBytes': imageBytes,
      'email': email
    };
  }
}

Uint8List _getImageBinary(dynamicList) {
  List<int> intList = dynamicList.cast<int>().toList();
  Uint8List data = Uint8List.fromList(intList);

  return data;
}