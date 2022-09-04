import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/RoyalServices/ApiServices/RoyalApiServices.dart';
import 'package:learningplatform_rb/database/LocalGamesLevel.dart';
import 'package:learningplatform_rb/database/base_local.dart';
class InformationGamesRepo{
  InformationGamesRepo._();
  static final instanse=InformationGamesRepo._();
  LocalInfoGameLevels local=LocalInfoGameLevels.instanse;
  bringapi()async{
    String url=Api.infogameslevels;
    String token=await BaseLocal.token();
  RS response=  await RoyalApiServices.get(url,token:token);
  if(response==null){return null;}
    local.save(response.toMap());
    return response.data['game'];
  }
  postanswer(Map body)async{
    String url=Api.postAnswerUrl;
    String token=await BaseLocal.token();
    RS response=  await RoyalApiServices.post(url,token:token,body: body);
    if(response==null){return null;}
    local.save(response.toMap());
    return response.data['game'];
  }





  bringlocal()async{
    var json=await local.read();
   try{
     RS response=RS.fromJson(json);
     return response.data['game'];
   }catch (e){
   }
  return null;
  }

}