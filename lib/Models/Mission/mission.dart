import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';

class Mission extends RoyalGeneralModel{
  SubjectModel subject;
  Mission.fromjson(json){
    subject=SubjectModel.fromJson(json['subject']);
  }
}