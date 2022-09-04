import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/Students/Customer.dart';
import 'package:learningplatform_rb/providers/RoyalBoardProvider/royal_board_provider.dart';

class BestStudentsProvider extends RoyalBoardProvider{
  BestStudentsProvider():super(Api.bestStudents);
  final ValueNotifier<List<User>> bests=ValueNotifier(null);
  init(){
    local();
    api();
  }
  api()async{
    final dynamic data=await getFromInternet();
    if(data!=null)buildNotifier(data);
  }
  local(){
    final dynamic data=getFromDataBase();
    if(data !=null)buildNotifier(data);
  }

  buildNotifier(final dynamic data){
   if(data is List){
     bests.value=List.from([]);
     data.forEach((json){
       bests.value=List.from(bests.value)..add(User.fromjson(json));
     });
   }
  }
}