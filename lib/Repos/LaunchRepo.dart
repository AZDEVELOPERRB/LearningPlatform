import 'dart:convert';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:http/http.dart' as http;
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/database/base_local.dart';

class LaunchRepo{
  countries()async{
    var response=await http.get(Api.Countries_Url,headers: Api.headers());
    var json=jsonDecode(response.body);
     RS _res=RS.fromJson(json);
    await BaseLocal().saveCountries(json['data']);
   return _res.data;
  }
}