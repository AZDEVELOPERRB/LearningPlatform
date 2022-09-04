import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Chapters/chapter.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Home/Subjects/Chapters/chapter_view.dart';
import 'package:learningplatform_rb/UI/CustomerExams/customer_exams.dart';
import 'package:learningplatform_rb/UI/Teacher/Missions/Chapter/teacher_single_chapter.dart';
class SingleSubjectClass extends StatelessWidget {
  const SingleSubjectClass(this.subject,{this.isStudent=true});
  final  SubjectModel subject;
final bool isStudent;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Directionality(
      textDirection:TextDirection.rtl,
      child: Scaffold(
        floatingActionButton:isStudent?RoyalRoundedButton(""
            "امتحانات هذه المادة",(){
          Navigator.push(context,RoyalNavigatorElasticInOut(CustomerExams(subjectId:subject.id,)));
        },circular:25,buttoncolor:Colors.blueAccent):const SizedBox(),
        floatingActionButtonLocation:FloatingActionButtonLocation.endFloat ,
        appBar:UiConstans.appBar(size:size,title: Text('الفصول الدراسية لمادة ${subject.name}')),
        body:ListView(
          children: [
            Directionality(
              textDirection:TextDirection.rtl,
              child: GridView.count(
                primary:false,
                shrinkWrap:true,
                crossAxisCount:2,
                children:List.generate(subject.chapters.length, (index) => chapterWidget(subject.chapters[index],context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
InkWell chapterWidget(ChapterModel chapter,BuildContext context){
    return InkWell(
      onTap:(){
        if(chapter.lessons.isEmpty){Constans.toast("هذا الفصل لا يحتوي على دروس",false);return;}
        if(isStudent){
          Navigator.push(context,RoyalNavigatorElasticInOut(ChapterView(chapter)));
        }else{
          Navigator.push(context,RoyalNavigatorElasticInOut(TeacherSingleChapter(chapter)));

        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          alignment:const Alignment(0.75,1.0),
            decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image:const DecorationImage(
                  image:const AssetImage(Constans.imagePath+"study.jpg"),
                  fit: BoxFit.scaleDown
                ),
                boxShadow:[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius:8,
                    blurRadius:7,
                    offset:const Offset(0, 3), // changes position of shadow
                  ),
                ]
            ),
            child:Text(chapter.name,style:const TextStyle(color: Colors.brown,fontWeight: FontWeight.w900,fontSize:15),)),
      ),
    );
  }
}
