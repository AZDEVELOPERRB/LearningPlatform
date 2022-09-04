import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Models/Students/Customer.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/userRepo.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
import 'package:learningplatform_rb/database/base_local.dart';
class UserProvider extends ChangeNotifier{
  final RoyalLoading royalLoading=RoyalLoading();
  BuildContext context;
  User user;
login(String email,String password,{bool isTeacher=false})async{
  var res= await UserRepo().login(email, password,isTeacher: isTeacher);
  return res;
}
register(Map body)async{
  return await UserRepo().register(body);
}

refresh()async{
  var _user=await UserRepo().userRefresh();
 if(_user==null){
   await Future.delayed(const Duration(seconds:5));
   refresh();
   return null;
 }
  user=_user;
return user;
}

getUser()async{
   User data=await UserRepo().getUser();
   user=data;
   notifyListeners();
   return user;
}
seen(){
  return BaseLocal().seen();
}


saveUser(var data)async{
  return await UserRepo.reposave(data,isLogin: true);
}

updateUser(Map body)async{
  loading();
 RS royalResponse=await UserRepo().update(body);
  getUser();
  endloading();
 return royalResponse;
}

 loading(){
  if(context!=null){
    royalLoading.loading(context);
  }
 }
  endloading(){
  royalLoading.cancel();
  }
}