import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/Models/Paginate/paginate_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/EamRepo/exam_repo.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
import 'package:learningplatform_rb/providers/PaginationProvider/pagination_provider.dart';
import 'package:learningplatform_rb/providers/Teacherprovider/teacher_provider.dart';

class AllExamsProvider  extends PaginationProvider{
  AllExamsProvider({final String id,final String url,final String token,this.body}):
        super(url:url??Api.allExams+id,token:token??TeacherProvider.instance.userNotifier.value.token);
  ValueNotifier<List<ExamModel>> exams=ValueNotifier(null);
  final ExamRepo _examReporepo=ExamRepo();
  final  RoyalLoading royalLoading= RoyalLoading();
 final Map body;
  initialize()async{
    if(pagination==null){
      dataBase();
    }
     internet();
   }

  internet()async{
    final Pagination p=await api(body:body??{});
    if(p!=null){
      notify(p);
    }
  }
  dataBase(){
    final  Pagination p=local();
    if(p!=null){
      notify(p);
    }
  }
  notify(final Pagination p){
    if(p?.current!=null && p.current>1){
      exams.value=exams.value;
    }else{
      exams.value=List.from([]);
    }
    final data=p?.data;
    if(data!=null && data is List && data.isNotEmpty){
      for (final json in p.data){
        exams.value=List.from(exams.value)..add(ExamModel.fromjson(json));
      }
    }
  }
  deleteExam(final int index,final BuildContext context)async{
    royalLoading.loading(context);
    final ExamModel e=exams.value[index];
   final RS rs=await _examReporepo.delete({"id":e.id});
   if(rs.check()){
     exams.value=List.from(exams.value)..removeAt(index);
     final Pagination localData=local();
     dynamic localList=localData.data;
     if(localList is List){
       for(int position =0;position<localList.length;position++){
         if(localData.data[position]['id']==e.id){
           localData.data.removeAt(position);
         }
       }
     }
   }
    royalLoading.cancel();
  }
}

