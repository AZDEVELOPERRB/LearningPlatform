import 'package:hive/hive.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Constans/locals_constans.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';

class SubjectsDB{
  SubjectsDB._();
static final db=SubjectsDB._();
final String name=Local_Constans.subjectsBox;
final String key=Local_Constans.subjectsBoxKey;
List<SubjectModel> subjects=[];
 Box box;
 get()async{
   if(box==null)await init();
   final value=box.get(key);
   if(value==null)return value;
   setSubjectsModels(value);
   return subjects;
 }
 insert(RS rs){
   if(rs.msg=="Subjects")insertSubjectsAndChapters(rs.data);
 }


 insertSubjectsAndChapters(var value)async{
   setSubjectsModels(value);
  return await box.put(key, value);
 }
 setSubjectsModels(var value){
   subjects=[];
   try{
     for (Map subject in value){
       subjects.add(SubjectModel.fromJson(subject));
     }

   }catch(e){
   }

 }
 ///Initialization of The Subjects DataBase
Future<Box>init()async{
   if(box==null){
     await Hive.openBox(name);
     box=Hive.box(name);
   }
   return box;
 }
}