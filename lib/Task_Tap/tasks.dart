class Task{//data class used to save task in the data base
  static const String  collectionName='Tasks';
  String ?id;
  String ?title;
  String ?description;
  DateTime ?date;
  bool? isDone;

  Task({this.id='',
    required this.title,
    required this.description,
    required this.date,
    this.isDone=false});

  Task.fromFireStore(Map<String,dynamic>Data){
    id=Data['id']as String?;
    title=Data['title'];
    description=Data['description'];
    date=DateTime.fromMillisecondsSinceEpoch(Data['date']);
    isDone=Data['isDone'];
  }

  Map<String,dynamic> toFireStore(){//convert class data to json so we can save it on firebase
    return{
      'id':id,
      'title':title,
      'description':description,
      'date':date?.millisecondsSinceEpoch,//time since 1970 in sec
      'isDone':isDone
    };
  }


}