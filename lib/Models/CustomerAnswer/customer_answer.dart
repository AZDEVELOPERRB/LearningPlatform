import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';

class CustomerAnswer extends RoyalGeneralModel{
  String id;
  Student student;
  int result;
  ExamModel exam;
  bool done=false;
  CustomerAnswer({this.id,this.student, this.exam});

  CustomerAnswer.fromjson(json){
    id=json['id'];
    result=json['result'];
    student=Student.fromjson(json['student']);
    exam=ExamModel.fromjson(json['exam']);
  }
}
class Student extends RoyalGeneralModel{
  String id,name;
  Student({this.id,this.name});
  Student.fromjson(json){
    id=json['id'];
    name=json['name'];
  }
}