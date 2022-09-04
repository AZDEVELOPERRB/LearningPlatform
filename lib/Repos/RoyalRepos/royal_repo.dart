import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/RoyalServices/ApiServices/RoyalApiServices.dart';

class RoyalRepo{
  final String url;
   String token;
  RoyalRepo(this.url,{this.token});
 Future<RS> get({String nUrl})async{
    final RS response=await RoyalApiServices.get(nUrl??url,token:token??Api.first_key);
    return response;
  }

  Future<RS> post(Map body,{String nUrl,})async{
    final RS response=await RoyalApiServices.post(nUrl??url,body:body,token:token??Api.first_key);
   return response;
  }

  Future<RS> updateTeacher(Map body)async{
   final RS rs=await post(body,nUrl:Api.updateTeacher);
   return rs;
  }
  Future<RS> updatePassword(Map body)async{
    final RS rs=await post(body,nUrl:Api.updatePassword);
    return rs;
  }
}