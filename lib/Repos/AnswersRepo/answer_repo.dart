import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/RoyalRepos/royal_repo.dart';
import 'package:learningplatform_rb/database/base_local.dart';

class AnswerRepo extends RoyalRepo{
  AnswerRepo():super(Api.customeranswerExam,token:BaseLocal.token());
  Future<RS> postAnswer(final Map body)async{
    return await post(body);
  }
}