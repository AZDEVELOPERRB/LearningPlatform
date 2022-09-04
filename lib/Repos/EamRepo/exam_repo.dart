import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/RoyalRepos/royal_repo.dart';
import 'package:learningplatform_rb/database/base_local.dart';

class ExamRepo extends RoyalRepo{
  ExamRepo() : super(Api.createExam,token:BaseLocal.token());
  Future<RS> create(final Map body)async{
    return await post(body);
  }

  Future<RS> delete(final Map body)async{
    return await post(body,nUrl:Api.deleteExam);
  }
}