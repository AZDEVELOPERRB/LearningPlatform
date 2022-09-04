import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Repos/RoyalRepos/royal_repo.dart';
import 'package:learningplatform_rb/providers/Teacherprovider/teacher_provider.dart';

class TeachersMissionsRepo extends RoyalRepo{
  TeachersMissionsRepo() : super(Api.missions,token:TeacherProvider.instance.userNotifier.value.token);
}