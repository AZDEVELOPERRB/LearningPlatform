import 'package:hive/hive.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/locals_constans.dart';
import 'package:learningplatform_rb/Models/GPS/Countries.dart';
import 'package:learningplatform_rb/Models/Students/Customer.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/LaunchRepo.dart';
class BaseLocal{
  String userDatabase=Local_Constans.local_user_info;
  String userKey=Local_Constans.local_user_key;
  saveUserInfo(var data)async{
    var box=Hive.box(userDatabase);
    await box.put(userKey, data);
  }
  logout()async{
    return await saveUserInfo({'status':'error', 'msg':'not_auth', 'data':'error', 'toast':'error',});
  }
  userModel(){
    User userModel;
    try {
    RS royalResponse=RS.fromJson( readUser());
   if(royalResponse.Auth()){
       User user=User.fromjson(royalResponse.data);
       if(user==null)logout();
       userModel= user;
     }
   }
    catch (e) {
      logout();
      Constans.toast(Constans.modelerror, false); // Catches all types of `Exception` and `Error`.
    }
    if(userModel==null)logout();
   return userModel;
  }


static  token<String>(){
    try{
     User _user= BaseLocal().userModel();
     return _user.token;
   }catch(e){
      if(Constans.royalDebug)print(e.toString());
     Constans.toast("يوجد خطأ في حسابك الداخلي للهاتف", false);
     return 'noapi';
   }

  }
  static  userId<String>(){
    try{
      User _user= BaseLocal().userModel();
      return _user?.id??null;
    }catch(e){
      Constans.toast("يوجد خطأ في حسابك الداخلي للهاتف", false);
      return null;
    }

  }
  readUser(){
    var box=Hive.box(userDatabase);
    return  box.get(userKey);
  }


  bringCountries()async{

    var box=  Hive.box(Local_Constans.Countries);
    var get=await box.get(Local_Constans.Countries_key);
    List<Countries> da=[];
    LaunchRepo().countries();
    if(get==null){
      var _countries=Constans.contries;
      da=[];
      for(var c in _countries){
        da.add( Countries.fromjson(c)) ;
      }

    }
    else{
      da=[];
      for(var c in get){
        da.add( Countries.fromjson(c)) ;
      }
    }
    return da;
  }
  saveCountries(var data)async{
    var box=  Hive.box(Local_Constans.Countries);
   await box.put(Local_Constans.Countries_key,data);
    return true;
  }
  seen()async{

    Box seen=Hive.box(Local_Constans.seen);
  return  await seen.put(Local_Constans.seen_key, "Auth");
  }
}