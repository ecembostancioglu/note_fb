class Note{
   String? id;
   String? title;
   String? description;
   DateTime? created;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.created});


  Map<String,dynamic> toMap() =>{
    'id':id,
    'title':title,
    'description':description,
    'created':created,
   };

   factory Note.fromMap(Map map) => Note(
     id:map['id'],
     title:map['title'],
     description:map['description'],
     created:map['created'],
   );


}