import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/Models/QuestionModel/question_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/AnswersRepo/answer_repo.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
class AnswerHandler{
  AnswerHandler(this.exam);
  ExamModel exam;
  final AnswerRepo repo=AnswerRepo();
  final RoyalLoading loading=RoyalLoading();
  List<Map> answers=[];
  sendAnswers(BuildContext context,{Function (int result) onExamCorrected})async{
    bool justSelecting=true;
    answers=[];
    for(final QuestionModel q in exam.questions){
     if(q.answer.value!=null&&q.answer.value.questionId!=null){
       if(q.type.id!="select")justSelecting=false;
       answers.add(q.answer.value.toMap());
     }else{
       answers=[];
       Constans.toast("يجب الاجابة على جميع الاسئلة",false);
       return;
     }
    }
    final Map body={"exam":exam.id, "data":jsonEncode(answers)};
    loading.loading(context);
   final RS rs= await repo.postAnswer(body);
    loading.cancel();
   if(rs.check()){
     exam.done=true;
     if(justSelecting && rs.data is int){
      return onExamCorrected(rs.data);
     }
     Navigator.pop(context);
     Navigator.pop(context);
   }
  }

  reFormat(){
    exam.questions.forEach((QuestionModel element) {
      element.answer.value=null;
    });
    answers=[];
  }
}