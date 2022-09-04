import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/gradesModels/schoolType.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/RoyalServices/ApiServices/RoyalApiServices.dart';
import 'package:learningplatform_rb/database/base_local.dart';
import 'package:learningplatform_rb/database/gradesLocal.dart';
class GradesRepo{
  Future<RS> postNewGrade(Map body)async{
    RS royalresponse=await RoyalApiServices.post(Api.postGrades,body: body, token: await BaseLocal.token());
    return royalresponse??null;
  }
  allGradesFromApi()async{
    String token= await BaseLocal.token();
    RS response=await RoyalApiServices.get(Api.allGrades,token:token);
    if(response==null){return null;}
   GradesLocal.saveGradesLocal(response.data);
   List<SchoolType> schoolTypes=[];
   for (var s in response.data){
     schoolTypes.add(SchoolType.fromjson(s));
   }
   return schoolTypes;
  }

  allGradesFromLocal()async{
    var localgrades=await GradesLocal.ReadeGradesLocal();
    List<SchoolType> schoolTypes=[];
    if(localgrades!=null){
    try{
      for (var s in localgrades){
        schoolTypes.add(SchoolType.fromjson(s));
      }
      return schoolTypes;
    }catch(e){
      royalformatlocal();
      Constans.toast(Constans.modelerror, false);
    }
    }
    return null;
  }
  royalformatlocal()async{
    return await GradesLocal.RoyalFormatLocalModel();
  }

}