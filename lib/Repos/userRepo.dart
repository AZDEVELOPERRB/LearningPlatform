import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/RoyalServices/ApiServices/RoyalApiServices.dart';
import 'package:learningplatform_rb/database/base_local.dart';
class UserRepo{
  login(String email ,String password ,{bool isTeacher=false})async{


    var body={
      "email":email,
      "password":password,
      "fcm":await Constans.fcm()
    };

    var response= await RoyalApiServices.post(isTeacher?Api.teachers_login_url:Api.login,body: body);
    if(response==null){return null;}
   reposave(response.toMap());
    return response;
  }
  register(Map body)async{
    body['fcm']=await Constans.fcm();
    RS royalresponse=await RoyalApiServices.post(Api.Register,body:body);
    if(royalresponse==null){return null;}
    return royalresponse;
  }



  userRefresh()async{
    var _user=await BaseLocal().userModel();
   if(_user==null){BaseLocal().logout();}
   print(_user.token);
   final RS royalresponse=await RoyalApiServices.get(Api.customerRefresh,token:_user.token);
   if(royalresponse==null){return null;}
    reposave(royalresponse.toMap());
   return await BaseLocal().userModel();
  }




  firstfcm()async{
    var _user=await BaseLocal().userModel();
    if(_user==null){BaseLocal().logout();}
    String ftoken=await Constans.fcm();
    RS royalresponse=await RoyalApiServices.post(Api.fcm,token:_user.token,body: {'fcm':ftoken});
    return royalresponse;
  }

  Future<RS> update(Map body)async{
    var _user=await BaseLocal().userModel();
    if(_user==null){BaseLocal().logout();}
  RS royalresponse=await RoyalApiServices.post(Api.customerUpdate,token:_user.token,body: body);
    return royalresponse;
  }

  feedback(Map body)async{
    var _user=await BaseLocal().userModel();
    if(_user==null){BaseLocal().logout();}
    RS royalresponse=await RoyalApiServices.post(Api.feedback,token:_user.token,body: body);
    return royalresponse;
  }
getUser()async{
    return await BaseLocal().userModel();
  }
 static reposave(var json,{bool isLogin=false})async{
    RS data=RS.fromJson(json);
    await BaseLocal().saveUserInfo(json);
    return data;
  }


}