import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/database/base_local.dart';
class RoyalApiServices{
  static  post(String url,{Map body,String token})async{
   if(Constans.royalDebug)print(url);
    var response= await http.post(url,headers: token==null?Api.headers():Api.headers(token:token),body:jsonEncode(body))
      .catchError((error) {Constans.toast("يوجد خلل في الاتصال بالانترنت والخدمات", false);
      if(Constans.royalDebug)print(error);
      return null;});
  if(response==null){return null;}
  if(response.statusCode==200){
   return await royalResponse(response);
  }
  return await royalResponse(response);
 }
 static  get(String url,{String token})async{
   if(Constans.royalDebug)print(url);
  var response=await http.get(url,headers: token==null?Api.headers():Api.headers(token: token))
      .catchError((error) {Constans.toast("يوجد خلل في الاتصال بالانترنت والخدمات", false);return null;});
  if(response==null){return null;}
  if(response.statusCode==200){
   return await royalResponse(response);
  }
 }
static   royalResponse(http.Response response)async{
  final dynamic json=jsonDecode(response.body);
  print(json);
  try{
   RS royalResponse=RS.fromJson(json);
   if(royalResponse.saveAuth()){
    BaseLocal().saveUserInfo(json);
   }
   if(royalResponse.RoyalToast()==true){
    Constans.toast(royalResponse.toast, royalResponse.check());
   }
   if(royalResponse.Auth()==false||royalResponse.msg=='validator'){
    return null;
   }
   return royalResponse;
  }catch(e){
   Constans.toast("هنالك خطأ في استقبال المعلومات من السيرفر", false);
   return null;
  }
  }



}
