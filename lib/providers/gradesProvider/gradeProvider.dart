import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Models/gradesModels/ClassType.dart';
import 'package:learningplatform_rb/Models/gradesModels/SubcOne.dart';
import 'package:learningplatform_rb/Models/gradesModels/SubcTow.dart';
import 'package:learningplatform_rb/Models/gradesModels/schoolType.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/GradesRepo.dart';
import 'package:learningplatform_rb/UI/GradesSelect/SchoolsChoser.dart';

class GradeProvider extends ChangeNotifier{

  bool loading=false;
  SchoolsTypeChoser schoolchoser;
  SchoolType chosedSchool;
  ClassType chosedclass;
  SubcOne chosedsubcone;
  SubcTow chosedsubctow;
  Map postServerGrade;
  List<SchoolType> hiddenschoolsType=[];
  int schoolChose;




  fetchLocalData()async{
    List<SchoolType> localGrades= await GradesRepo().allGradesFromLocal();
    if(localGrades!=null){
      royalsetter(localGrades);
      return localGrades;
    }
    return null;
  }





  getAllGrades()async{


   if( fetchLocalData()==null){
     progress();
   }
   var schooltype= await GradesRepo().allGradesFromApi();
   if(loading){ dismiss();}
  await royalsetter(schooltype);

  }



  royalsetter( List<SchoolType> data){
    hiddenschoolsType=data;
    schoolchoser=SchoolsTypeChoser(hiddenschoolsType,provider: this);
    notifyListeners();
  }





post()async{
  progress();
  final RS rs=await GradesRepo().postNewGrade(postServerGrade);
  dismiss();
  return rs;
}


  chose(SchoolType chosen){
    if(chosedSchool!=null){
      if(chosen.id==chosedSchool.id){
        chosedSchool=null;

      }
      else{
        chosedSchool=chosen;
      }
    }
    else{
      chosedSchool=chosen;
    }
    chosedclass=null;
    chosedsubcone=null;
    chosedsubctow=null;
    postServerGrade=null;


    notifyListeners();
  }






choseClass(ClassType chosen){
  postServerGrade=null;
  if(chosedclass!=null){
    if(chosen.id==chosedclass.id){
      chosedclass=null;

    }
    else{
      chosedclass=chosen;
      prepeareMap(chosen.id,chosen.className);
    }
  }
  else{
    chosedclass=chosen;
    prepeareMap(chosen.id,chosen.className);

  }
  chosedsubcone=null;
  chosedsubctow=null;


    notifyListeners();
}




  choseSubcOne(SubcOne chosen){
    postServerGrade=null;
    if(chosedsubcone!=null){
      if(chosen.id==chosedsubcone.id){
        chosedsubcone=null;
      }
      else{

        chosedsubcone=chosen;
        prepeareMap(chosen.id,chosen.className);

      }
    }
    else{
      chosedsubcone=chosen;
      prepeareMap(chosen.id,chosen.className);
    }


    notifyListeners();
  }



  choseSubcTow(SubcTow chosen){
    postServerGrade=null;
    if(chosedsubctow!=null){
      if(chosen.id==chosedsubctow.id){
        chosedsubctow=null;
      }
      else{


        chosedsubctow=chosen;
        prepeareMap(chosen.id,chosen.className);
      }
    }
    else{
      chosedsubctow=chosen;
      prepeareMap(chosen.id,chosen.className);
    }

    notifyListeners();
  }


//chosing School
  choseSchool(SchoolType schoolType){
    chosedSchool=schoolType;
    postServerGrade=null;
    notifyListeners();
  }

//prepeare Map for Server
  prepeareMap(String id,String type){
    if(type==ClassType.ocn){
      if(chosedclass.hasChild()){
        return false;
      }
    }
    if(type==SubcOne.ocn){
      if(chosedsubcone.hasChild()){
        return false;
      }
    }
    if(type==SubcTow.ocn){
      if(chosedsubctow.hasChild()){
        return false;
      }
    }
    postServerGrade={
      "className":type,
    "id":id
    };
  }
  progress(){
    loading=true;
    notifyListeners();
  }
  dismiss(){
    loading=false;
    notifyListeners();
  }
List<SchoolType> get schoolsType =>hiddenschoolsType;
}