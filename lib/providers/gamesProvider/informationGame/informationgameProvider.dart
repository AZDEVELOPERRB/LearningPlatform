import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/infoGameModel/InfoGameModel.dart';
import 'package:learningplatform_rb/Repos/informationgamesRepo/informationgameRepo.dart';

class InformationGameProvider with ChangeNotifier{
InformationGamesRepo repo=InformationGamesRepo.instanse;
bool isLoading=false;
 List<InfoGameLevels> questions;
  bringlevelsfromapi()async{
    var data=await repo.bringapi();
    if(data==null){await Future.delayed(Duration(seconds: 7));bringlevelsfromapi();return;}else{handel(data);}
  }
  initial()async{
    var data= await repo.bringlocal();
    if(data==null){isLoading=true;notifyListeners();await bringlevelsfromapi();}else{

      handel(data);
      bringlevelsfromapi();
    }
  }


handel(var data)async{
  questions=[];
 for (var json in data){
   try{
     questions.add(InfoGameLevels.fromjson(json));
   }catch(e){
     Constans.toast(e.toString(), false);
    await bringlevelsfromapi();
   }
 }
 if(isLoading){isLoading=false;}
  notifyListeners();
}
postanswer(String answer)async{

    Map body={"answer":answer};
    var data=await repo.postanswer(body);
    handel(data);
}
}