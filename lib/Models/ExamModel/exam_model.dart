import 'package:learningplatform_rb/Models/QuestionModel/question_model.dart';
import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
class ExamModel extends RoyalGeneralModel{
  String id,name,subjectId,created,now;
  int minutes;
  int result;
  SubjectModel subject;
  bool done;
  bool hasRight;
  List<QuestionModel> questions=[];
  int totalExamDegrees;
  int minimumDegree;
  ExamModel.fromjson(json){
   if(json is Map&&json.containsKey("id")){
     id=json['id'];
     name=json['name'];
     subjectId=json['subject_id'];
     minutes=int.parse(json['minutes'].toString());
     if(json.containsKey('created'))created="${json['created']}";
     now="${json['now']}";
     if(json.containsKey('done')&&json['done']==1){
       done=true;
     }else{
       done=false;
     }
     if(json.containsKey('questions')){
       final q=json['questions'];
       if(hasValueOfList(q)){
         totalExamDegrees=0;
         for (final j in q){
           final QuestionModel question=QuestionModel.fromjson(j);
           totalExamDegrees+=int.parse(question.marks);
           questions.add(question);
         }
       }
     }
     if(json.containsKey('result')){
       result=json['result'];
       minimumDegree=(totalExamDegrees/1.69).ceil();
       if(result!=null){
         hasRight=result<minimumDegree;
       }
       else{
         hasRight=true;
       }

     }
     if(json.containsKey("subject")){
       subject=SubjectModel.fromJson(json['subject']);
     }

   }
  }

}