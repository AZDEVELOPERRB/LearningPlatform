class City{
  String id,name;

  City({this.id, this.name});

  City.fromjson(json){this.id=json['id'];this.name=json['name'];}

}