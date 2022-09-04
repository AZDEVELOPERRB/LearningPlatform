import 'package:learningplatform_rb/Constans/locals_constans.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Chapters/chapter.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/RoyalServices/RoyalLocalNotification/royal_local_notification.dart';
import 'package:learningplatform_rb/database/RoyalDatabaseHandler/royal_database.dart';
class AnkiScheduleCacheSystem extends RoyalLocalDataBase {
  AnkiScheduleCacheSystem(this.key,this.subject,this.chapter)
      : super(Local_Constans.ankiSchedule, Local_Constans.ankiSchedule);
  final String key;
  final SubjectModel subject;
  final ChapterModel chapter;
  final String normal = "normal";
  final String learning = "learning";
  final String time = "time";
  final String timeHours ='hours';
  saveAnkiData(final dynamic data) async {
     Map localKey=bringKey();
     Map no=localKey[normal];
     Map le=localKey[learning];
     Map t;
     if(localKey.containsKey(time)){
       t=localKey[time]??{};
     }else{
       t={};
     }
     if(data is List)for(dynamic singleCard in data){

       if(singleCard is Map && singleCard.containsKey("id")){
         final String id=singleCard["id"];
         if(le.containsKey(id)){
           le[id]=singleCard;
         }else if(t.containsKey(id)){

         }else{
           no[id]=singleCard;
         }
       }}

     Map formData={
       normal:no,
       learning:le,
       time:t,
     };
     return save(formData);

  }
  save(Map savedData)async{
    Map formedData=bringAll();
    formedData[key]=savedData;
    await insert(formedData);
    return savedData;
  }

  changeOver(final String id,{final String from="normal",final String to="learning",int hours,final bool remove=true})async{
     Map keyMap=bringKey();
    Map fromMap=keyMap.containsKey(from)?keyMap[from]:{};
    Map toMap;
    if(keyMap.containsKey(to)){

    }else{
      keyMap[to]={};
    }
     toMap=keyMap[to];
    if(fromMap.isNotEmpty)fromMap.forEach((key, value){
      if(key==id){
        if(toMap.containsKey(key))toMap.remove(key);
        dynamic newValue=value;
        if(hours!=null){
          int oldHours=0;
          if(value is Map&& value.containsKey(timeHours)){

            try{
              oldHours=int.parse(value[timeHours].toString());
            }catch(e){

            }
          }
          newValue[timeHours]=Constans.ankiSchedulingHours(hours:hours,oldHours:oldHours);
          newValue[time]=DateTime.now().add(Duration(hours:newValue[timeHours]));
        }
        toMap[key]=newValue;
      }
    });
    keyMap[to]=toMap;
   if(remove) keyMap[fromMap]=fromMap.remove(id);
    await save(keyMap);

  }





  Map bringAll(){
     dynamic all=get();
    if(all is Map ) return all;
    return{};
  }



  notifyNearestCard(){
    DateTime nearestTime;
    final Map keyMap=bringKey();
    if(keyMap.containsKey(time)){
      final schedulingMap=keyMap[time];
      if(schedulingMap is Map){
        schedulingMap.forEach((key,value){
          if(value is Map&& value.containsKey(time)){
            try{
              DateTime cardTime=DateTime.parse(value[time].toString());
              nearestTime??=cardTime;
              if(cardTime.isBefore(nearestTime))nearestTime=cardTime;
            }catch(e){

              print(e);

            }
          }
        });
      }
    }
    if(nearestTime!=null){
      final String title="لديك بطاقات تستحق المراجعة في مادة "+subject.name;
      final String body=""
          "نظام التكرار المتباعد يرصد بطاقات دراسية تلزم المراجعة"+
          "قم بالدخول الى التطبيق واختر المادة  ${subject.name}"+
          "بعدها قم بالدخول الى ${chapter.name}"+
          "\n"
          +" "+
          "ثم قم بالدخول الى طور المراجعة الدراسية";
      RoyalLocalNotification.instance.showNotification(
          title:title,
          body:body,
          payLoad:chapter.id,
          selectedDateTime:nearestTime
      );
    }
  }


  /// bring information of Single Chapter
    bringKey() {
    final dynamic data=bringAll();
    if(data is Map){
      if(data.containsKey(key)){
        final dynamic switcher=data[key];
        if(switcher is Map && switcher.containsKey(normal)&&switcher.containsKey(learning)){
          if(switcher[normal] is Map && switcher[learning] is Map) return switcher;
        }
      }
    }

    return {
      normal:{},
      learning:{},
      time:{}
    };

  }



}
