import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
import 'package:learningplatform_rb/providers/ExamProvider/exam_provider.dart';

class EaxmHandler{
  EaxmHandler(this.subjectId);
  final String subjectId;
  final RoyalLoading loading=RoyalLoading();
  int minutes=120;
  final ValueNotifier<List<Question>> questionsList=ValueNotifier([]);
  final ExamProvider provider=ExamProvider();

  /// Exam Conditions
   final TextEditingController examName=TextEditingController();
   final TextEditingController examTime=TextEditingController(text:"120");


  createExam(BuildContext context,{final bool isPublicExam=true,Function(ExamModel exam) onCreatingDone})async{
    List<Map> list=[];
    for(final Question q in questionsList.value){
      if(q.type.id!="select"&&q.idealAnswer==null){
        Constans.toast("يجب وجود اجوبة مثالية لجميع الاسئلة", false);
        return;
      }
      list.add(q.toMap());
    }
    loading.loading(context);
   final RS rs=await provider.create({"data":jsonEncode(list),"subjectId":subjectId,'minutes':examTime.text,"name":examName.text,
   if(isPublicExam==false)"isPrivate":"true"
   });
   loading.cancel();
    if(rs.check()){
      Navigator.pop(context);
      onCreatingDone(ExamModel.fromjson(rs.data));
    }
  }

  bool validator(){
    if(!Constans.checkTextInputs([examName,examTime],message:"يجب ان يكون اسم الامتحان والحقل صحيحات"))return false;
    if(!Constans.isInteger(examTime.text)){Constans.toast("يجب ان يكون وقت الامتحانات رقم صحيح بالدقائق وبالارقام الانكليزية",false);return false;}
    return true;
  }
}





