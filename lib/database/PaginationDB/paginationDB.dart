import 'package:learningplatform_rb/Constans/locals_constans.dart';
import 'package:learningplatform_rb/database/RoyalDatabaseHandler/royal_database.dart';

class PaginationDB extends RoyalLocalDataBase{
  PaginationDB(final String key) : super(Local_Constans.pagination,key);
}