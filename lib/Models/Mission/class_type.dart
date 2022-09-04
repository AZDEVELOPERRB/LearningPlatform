class ClassType {
  String name,id;
  ClassType.fromjson(json){
    id=json['id'];
    name=json['name'];
  }
}