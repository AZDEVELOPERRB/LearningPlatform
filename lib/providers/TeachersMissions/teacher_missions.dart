
import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Models/Mission/mission.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/TeachersMissionsRepo/teachers_missions_repo.dart';
import 'package:learningplatform_rb/database/TeachersMissions/teachers_missions_db.dart';

class TeacherMissionsProvider {
  final DBTeachersMissions db=DBTeachersMissions();
  final TeachersMissionsRepo repo=TeachersMissionsRepo();
  final ValueNotifier<List<Mission>> missions=ValueNotifier(null);
  final ValueNotifier<bool> loading=ValueNotifier(false);

  init(){
    local();
    internet();
  }
  local(){
    final data=db.get();
    if(data==null)return;
    buildData(data);
  }
  internet()async{
    loading.value=true;
    final RS data=await repo.get();
    loading.value=false;
    if(data==null){reCallInternet();return;}
    if(data.msg!="missions"){reCallInternet();return;}
    buildData(data.data);
    db.insert(data.data);
  }

  buildData(final data){
    List<Mission> m=[];
    if(data is List && data.isNotEmpty){
      for(final json in data){
        m.add(Mission.fromjson(json));
      }
    }
    missions.value=m;
  }


  reCallInternet()async{

  }
}