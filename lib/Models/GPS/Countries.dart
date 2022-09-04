import 'package:learningplatform_rb/Models/GPS/city.dart';

class Countries{
  String id,name;
  int status;
  List<City> CS;

  Countries({this.id, this.name, this.status, this.CS});
  Countries.fromjson(json){
    List<City> _st=[];

    for (var i in json['states']){

      _st.add(City.fromjson(i));

    }

    this.id=json['id'];
    this.name=json['name'];
    this.status=json['status'];
    this.CS=_st;

  }

}
class Country{
  String id,name;
  int status;

  Country({this.id, this.name, this.status});
  Country.fromjson(json){


    this.id=json['id'];
    this.name=json['name'];
    this.status=json['status'];

  }

}