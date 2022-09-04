import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/EamRepo/exam_repo.dart';

class ExamProvider{
final ExamRepo repo=ExamRepo();
static final ExamRepo staticRepo=ExamRepo();

  Future create(final Map body)async{
    final RS data= await repo.create(body);
    return data;
  }
  Future createPrivateExam(final Map body)async{
  final RS data= await repo.create(body);
  return data;
  }

  static Future<RS> removeQuickExam(final String examId)async{
    return await staticRepo.post({"id":examId},nUrl:Api.deleteQuickExam);
  }
}