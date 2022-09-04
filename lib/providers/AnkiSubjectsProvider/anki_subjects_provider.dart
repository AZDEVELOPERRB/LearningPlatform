import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/providers/RoyalBoardProvider/royal_board_provider.dart';
import 'package:learningplatform_rb/Repos/AnkiRepo/anki_repo.dart';
class AnkiSubjectsProvider extends RoyalBoardProvider{
  AnkiSubjectsProvider() : super(Api.ankiSubjects);
  final ValueNotifier<List<SubjectModel>> notifier=ValueNotifier(null);

  init(){
    cache();
   internet();
  }

  cache(){build(getFromDataBase());}


  internet()async{
    build(await getFromInternet());
  }

  build(final dynamic data){
    if(data is List){
      notifier.value=[];
      try{
        for(final dynamic json in data){
          notifier.value=List.from(notifier.value)..add(SubjectModel.fromJson(json));
        }
      }catch(e){
        Constans.toast("يرجى المحاولة لاحقاً",false);
      }
    }
  }



  buy(final BuildContext context,final String id)async{
    final AnkiRepo ankiRepo=AnkiRepo(id);
    royalLoading.loading(context);
   final RS rs= await ankiRepo.post({});
    royalLoading.cancel();
    if(rs.check()){
      try{
        SubjectModel subject=SubjectModel.fromJson(rs.data);
        updateNotifier(subject);
        updateLocalInformation(rs.data);
      }catch(e){

      }
    }

  }

  updateNotifier(final SubjectModel subject){
    if(notifier.value!=null && notifier.value.isNotEmpty){
      for(int i=0;i<notifier.value.length;i++){
        final SubjectModel old=notifier.value[i];
        if(old.id==subject.id){
          notifier.value[i]=subject;
          notifier.value=List.from(notifier.value);
        }
      }
    }
  }
}