class Note{
  String? title;
  String? description;
  DateTime? created;
  String? finishDate;

  Note({
    required this.title,
    required this.description,
    required this.created,
    required this.finishDate});

  Note.fromJson(Map<String,dynamic> json){
    title= json['title'];
    description= json['description'];
    created= json['created'];
    finishDate= json['finishDate'];
  }


  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title']=title;
    data['description']=description;
    data['created']=created;
    data['finishDate']=finishDate;
    return data;
  }

}
