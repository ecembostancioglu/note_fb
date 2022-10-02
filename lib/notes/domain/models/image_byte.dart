import 'dart:typed_data';

class ImageByte{
  Uint8List imageBytes;

  ImageByte({required this.imageBytes});

  ImageByte.fromMap(Map map):imageBytes = _getImageBinary(map['imageBytes']);

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