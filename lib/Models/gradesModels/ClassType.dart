import 'package:learningplatform_rb/Models/gradesModels/SubcOne.dart';
class ClassType{
  String id,name,className;
  int status,t;
 static String ocn="class_type";
  List<SubcOne> grade_childs=[];
  ClassType({this.id, this.name,this.className, this.status, this.t});
  ClassType.fromjson(json){
    this.id=json['id'];
    this.name=json['name'];
    this.className=json['className'];
    this.status=json['status'];
    this.t=json['t'];
    if(json['grade_childs'].length >0){
      for(var subcone in json['grade_childs']){
        grade_childs.add(SubcOne.fromjson(subcone));
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