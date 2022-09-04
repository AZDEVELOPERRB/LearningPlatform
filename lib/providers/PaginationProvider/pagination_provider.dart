import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Paginate/paginate_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/PaginationRepo/pagination_repo.dart';
import 'package:learningplatform_rb/database/PaginationDB/paginationDB.dart';
class PaginationProvider{
  PaginationProvider({@required this.url,@required final String token}):
  db=PaginationDB(url),
  repo=PaginationRepo(url,token);
  String url;



  /// Main Classes
  final PaginationRepo repo;
  Pagination pagination;
 final PaginationDB db;


 /// Notifiers
  final ValueNotifier<bool> loading=ValueNotifier(false);



 Pagination local(){
    final data=db.get();
    if(data!=null && data is Map && data.containsKey("data")){
      try{
        final Pagination pp=Pagination.fromjson(data);
        return pp;
      }catch(e){
        Constans.toast("يرجى متابعة الباجنيشن من الخوادم",false);
      }
    }
    return null;
  }
  /// Functions
  Future api({final Map body})async{
     RS rs;
     loading.value=true;
     if(pagination==null)rs=await repo.post(body??{});
     if(pagination?.next!=null)rs=await repo.post(body??{},nUrl:pagination.next);
     loading.value=false;
    if(rs!=null && rs.data !=null){
      final data=rs.data;
      if(data is Map &&data.containsKey("data")){save(data);return build(data);}
    }
    Constans.toast("لا يوجد المزيد ",false);
    return null;
  }
  build(final  data){
    try{
      pagination=Pagination.fromjson(data);
      return pagination;
    }catch(e){
      print(e.toString());
      Constans.toast("يرجى متابعة الباجنيشن من الخوادم",false);
    }
  }
  void save(final data)async{
   if(data!=null&& data is Map&&data.containsKey("current_page")&&data['current_page']==1){
     db.insert(data);
   }
  }
}