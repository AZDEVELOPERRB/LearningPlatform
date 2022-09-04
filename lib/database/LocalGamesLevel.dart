import 'package:hive/hive.dart';
import 'package:learningplatform_rb/Constans/locals_constans.dart';
class LocalInfoGameLevels{
  LocalInfoGameLevels._();
  static final instanse=LocalInfoGameLevels._();
  final String local=Local_Constans.infogame_local;
  final String key=Local_Constans.infogame_local;
  save(var data)async{
   Box box= Hive.box(local);
   await box.put(key, data);
 }

 read()async{
   Box box= Hive.box(local);
   return await box.get(key);
 }

}