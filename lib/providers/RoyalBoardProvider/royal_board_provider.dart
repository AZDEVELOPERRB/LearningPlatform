import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/RoyalProviderRepo/royal_provider_repo.dart';
import 'package:learningplatform_rb/database/RoyalProviderDataBase/royal_provider_database.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';

class RoyalBoardProvider{
  RoyalBoardProvider(this.url):dataBase=RoyalProviderDataBase(url),
  repo=RoyalProviderRepo(url);

  final RoyalLoading royalLoading=RoyalLoading();



  /// Constructor of The Class
  ///

  final String url;
  final ValueNotifier<bool> loading=ValueNotifier(false);
  final RoyalProviderDataBase dataBase;
  final RoyalProviderRepo repo;

  /// /////////////////////////////////////////////////////////////////////////////////////////////

  dynamic getFromDataBase(){
    final dynamic data= dataBase.get();
    if(data!=null&&data!="")return data;
    return null;
  }
 Future<dynamic> getFromInternet({final Map body})async{
    loading.value=true;
    final RS rs= await repo.post(body??{});
    loading.value=false;
    if(rs!=null){
      if(rs.data!=null){
        dataBase.insert(rs.data);
        return rs.data;
      }
    }
    return null;
  }


  updateLocalInformation(final dynamic model){
    if(model is Map && model.containsKey("id")){
      final dynamic localDataBase=getFromDataBase();
      if(localDataBase is List){
        for(int i=0;i<localDataBase.length;i++){
          final dynamic local=localDataBase[i];
          if(local is Map && local.containsKey("id")){
            if(local['id'].toString()==model['id'].toString()){
              localDataBase[i]=model;
              dataBase.insert(localDataBase);
            }
          }
        }
      }

    }
  }

}