import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/CustomerAnswer/customer_answer.dart';
import 'package:learningplatform_rb/Models/Paginate/paginate_model.dart';
import 'package:learningplatform_rb/database/base_local.dart';
import 'package:learningplatform_rb/providers/PaginationProvider/pagination_provider.dart';

class AllAnswersProvider extends AllResultsProvider{
  AllAnswersProvider(final String examId,{final bool quick=false}):super((quick==false?Api.examAnswers:Api.quickexamAnswers)+examId);
}


class AllResultsProvider extends PaginationProvider{
  AllResultsProvider(final String url):super(url:url,token:BaseLocal.token());
  final ValueNotifier<List<CustomerAnswer>> allAnswers=ValueNotifier(null);

  init(){
    dataBase();
    internet();
  }

  dataBase(){
    try{
      final Pagination pagination=local();
      if(pagination!=null){
        return buildAnswers(pagination.data);
      }
    }catch(e){}
  }

  internet()async{
    final Pagination pagination=await api();
    if(pagination!=null){
      return buildAnswers(pagination.data);
    }
  }
  answerCorrected(final String id,final int result){
    for(final CustomerAnswer answer in allAnswers.value){
      if(answer.id == id){
        answer.result=result;
      }
    }
    final Pagination pagination=local();
    final dynamic localList=pagination.data;
    if(localList !=null && localList is List){
      for(final dynamic answerLocal in localList){
        if(answerLocal['id']==id){
          answerLocal['result']=result;
        }
      }
      pagination.data=localList;
      save(pagination.toMap());
    }

  allAnswers.value=List.from(allAnswers.value);
  }
  buildAnswers(final dynamic data){
    allAnswers.value=[];
    for(final json in data){
      allAnswers.value=List.from(allAnswers.value)..add(CustomerAnswer.fromjson(json));
    }
  }
}