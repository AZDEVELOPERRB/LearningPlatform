import 'package:hive/hive.dart';
import 'package:learningplatform_rb/Constans/locals_constans.dart';



class GradesLocal{
static saveGradesLocal(var data)async{
  var box=Hive.box(Local_Constans.grades_local);
  await box.put(Local_Constans.grades_local_key, data);
  return true;
}



static ReadeGradesLocal()async{
  var box=Hive.box(Local_Constans.grades_local);
  return await box.get(Local_Constans.grades_local_key);
}

static RoyalFormatLocalModel()async{
  var box=Hive.box(Local_Constans.grades_local);
  return await box.delete(Local_Constans.grades_local_key);
}

}