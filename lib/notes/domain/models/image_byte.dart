import 'dart:typed_data';

class ImagesByte{
  Uint8List imageBytes;

  ImagesByte({required this.imageBytes});

  ImagesByte.fromMap(Map map):
        imageBytes = _getImageBinary(map['imageBytes']);

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