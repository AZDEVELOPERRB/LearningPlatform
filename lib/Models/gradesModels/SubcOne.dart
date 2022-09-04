import 'package:learningplatform_rb/Models/gradesModels/SubcTow.dart';

class SubcOne{
  String id,name,className;
  int status,t;
 static String ocn="subc_one";
  List<SubcTow> grade_childs=[];
  SubcOne({this.id, this.name,this.className, this.status, this.t});
  SubcOne.fromjson(json){
    this.id=json['id'];
    this.name=json['name'];
    this.className=json['className'];
    this.status=json['status'];
    if(json['grade_childs'].length >0){
      for(var subctow in json['grade_childs']){
        grade_childs.add(SubcTow.fromjson(subctow));
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