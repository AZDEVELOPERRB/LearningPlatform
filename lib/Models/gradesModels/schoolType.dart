import 'package:learningplatform_rb/Models/gradesModels/ClassType.dart';

class SchoolType{
  String id,name,className;
  int status,t;
 String ocn="school_type";
  List<ClassType>grade_childs=[];
  SchoolType({this.id, this.name,this.className, this.status, this.t});
  SchoolType.fromjson(json){
    this.id=json['id'];
    this.name=json['name'];
    this.className=json['className'];
    this.status=json['status'];
    this.t=json['t'];
    if(json['grade_childs'].length >0){
      for(var classType in json['grade_childs']){
        grade_childs.add(ClassType.fromjson(classType));
      }
    }
  }

bool hasChild(){
    if(this.grade_childs.length>0){
      return true;
    }
    return false;
}
}