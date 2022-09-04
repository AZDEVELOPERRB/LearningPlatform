import 'package:learningplatform_rb/Constans/locals_constans.dart';
import 'package:learningplatform_rb/database/RoyalDatabaseHandler/royal_database.dart';

class DBCompanyNotification extends RoyalLocalDataBase{
  DBCompanyNotification(final String localKey):super(Local_Constans.painationDataBase,localKey);
}