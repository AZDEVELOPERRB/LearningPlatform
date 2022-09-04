import 'package:hive/hive.dart';
abstract class RoyalLocalDataBase{
  RoyalLocalDataBase(this.dataBaseName, this.key){
    box=Hive.box(dataBaseName);
  }
  final String dataBaseName;
  final String key;
   Box box;
  get(){
   return box.get(key);
  }
  insert(final data)async{
   return await box.put(key,data);
  }

}