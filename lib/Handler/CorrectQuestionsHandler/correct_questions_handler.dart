import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/CustomerAnswer/customer_answer.dart';
import 'package:learningplatform_rb/Models/QuestionModel/question_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/CorrectAnswerRepo/correct_answer_repo.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';

class CorrectQuestionsHandler{
  CorrectQuestionsHandler(this.customerAnswer);
  final CustomerAnswer customerAnswer;
  final CorrectAnswerRepo repo=CorrectAnswerRepo();
  List<Map> postData=[];
  final RoyalLoading loading=RoyalLoading();
  bool running=false;
  correctExam(BuildContext context,{Function (int result) onResultComplete})async{
    postData=[];
    for(final QuestionModel question in customerAnswer.exam.questions){
      if(question.answer.value.result.value==null){
        Constans.toast("يجب تصحيح جميع الاجوبة",false);
        return;
      }
      postData.add(question.answer.value.correctAnswersMap());
    }
    
    loading.loading(context);
    final RS response=await repo.post({"data":jsonEncode(postData),"exam":customerAnswer.exam.id,'customer':customerAnswer.student.id});
    if(response.check()){
      if(response.msg=="success"){
        if(response.data is int){
          customerAnswer.result=response.data;
          if(onResultComplete!=null)onResultComplete(response.data);
        }
      }
      Navigator.pop(context);
    }
    loading.cancel();
  }
}