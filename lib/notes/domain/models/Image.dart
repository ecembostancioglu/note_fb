import 'dart:typed_data';

class Image{
  Uint8List? imageBytes;

  Image({required this.imageBytes});

  Image.fromMap(Map map):imageBytes = _getImageBinary(map['imageBytes']);

  Map toMap(){
    return{
      'imageBytes': imageBytes
    };
  }
}

Uint8List _getImageBinary(dynamicList) {
  List<int> intList = dynamicList.cast<int>().toList();
  Uint8List data = Uint8List.fromList(intList);

  return data;
}