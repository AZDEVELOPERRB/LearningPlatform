import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/database/base_local.dart';
import 'package:learningplatform_rb/providers/ExamProvider/AllExamsProvider/all_exams_provider.dart';

class CustomerExamsProvider extends AllExamsProvider{
  CustomerExamsProvider(final String subjectId):super(url:Api.customerExams+"/"+subjectId,token:BaseLocal.token(),body:{
    "subject_id":subjectId
  });
}