import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/RoyalServices/ApiServices/RoyalApiServices.dart';
import 'package:learningplatform_rb/database/base_local.dart';

class SubjectsRepo{
  static const String url=Api.subject;
  static  get()async{
    String token= await BaseLocal.token();
    final RS rs=await RoyalApiServices.get(url,token: token);
    return rs;
  }


}