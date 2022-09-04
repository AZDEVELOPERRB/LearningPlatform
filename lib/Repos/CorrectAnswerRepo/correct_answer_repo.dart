import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Repos/RoyalRepos/royal_repo.dart';
import 'package:learningplatform_rb/database/base_local.dart';

class CorrectAnswerRepo extends RoyalRepo{
  CorrectAnswerRepo() : super(Api.correctAnswer,token:BaseLocal.token());
}