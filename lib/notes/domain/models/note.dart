class Note{
   String? title;
   String? description;
  DateTime? created;

  Note({
    required this.title,
    required this.description,
    required this.created});


  Map<String,dynamic> toMap() =>{
    'title':title,
    'description':description,
    'created':created,
   };

   factory Note.fromMap(Map map) => Note(
     title:map['title'],
     description:map['description'],
     created:map['created'],
   );


}