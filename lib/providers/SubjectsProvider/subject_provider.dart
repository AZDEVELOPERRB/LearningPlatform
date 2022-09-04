import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/SubjectsRepo/subjects_repo.dart';
import 'package:learningplatform_rb/database/SubjectsDataBase/subjects_chapters_lessons.dart';

class SubjectProvider{
  final SubjectsDB db=SubjectsDB.db;
  List<SubjectModel> subjects;
  ValueNotifier<bool> loading=ValueNotifier(false);
  ValueNotifier<List<SubjectModel>>subjectsNotifier=ValueNotifier([]);
  getSubjects()async{
  await db.get();
  if(db.subjects!=null&&db.subjects.length>0){
   setSubjects();
  bringSubjectsApi();
  setSubjects();
  }
    else {
   await bringSubjectsApi();
    setSubjects();
    }
  }

  setSubjects()async{
    subjects=db.subjects;
    subjectsNotifier.value=subjects;
  }

  bringSubjectsApi()async{
    loading.value=true;
    RS rs=await getSubjectsFromApi();
    loading.value=false;
    if(rs!=null&&rs?.data is List){
      await db.insert(rs);
    }
  }
 Future<RS> getSubjectsFromApi()async{
    final RS rs=await SubjectsRepo.get();
    return rs;
  }

}