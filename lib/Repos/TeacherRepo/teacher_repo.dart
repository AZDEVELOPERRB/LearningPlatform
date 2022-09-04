import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/RoyalRepos/royal_repo.dart';
import 'package:learningplatform_rb/database/base_local.dart';

class TeacherRepo extends RoyalRepo{
  TeacherRepo({String url,String token}) : super(url??Api.teacherLogin,token:token);
  Future<RS>tLogin(final Map body)async{
    final RS rs=await post(body);
    return rs;
  }
  Future<RS>updateFcm(final Map body)async{
    final RS rs=await post(body,nUrl:Api.updateFcm);
    return rs;
  }
  Future<RS>refresh()async{
    final RS rs=await get(nUrl:Api.refreshTeacher);
    return rs;
  }

}