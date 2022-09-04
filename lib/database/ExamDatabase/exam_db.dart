import 'package:learningplatform_rb/Constans/locals_constans.dart';
import 'package:learningplatform_rb/database/RoyalDatabaseHandler/royal_database.dart';

class ExamDB extends RoyalLocalDataBase{
  ExamDB() : super(Local_Constans.examDb,Local_Constans.examDb);

}