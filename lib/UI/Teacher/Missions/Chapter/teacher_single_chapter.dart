import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Chapters/chapter.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/Models/Lessons/lesson.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
import 'package:learningplatform_rb/UI/Teacher/Correct/AllAnswers/all_answers.dart';
import 'package:learningplatform_rb/UI/Teacher/Exams/CreateExam/create_exam.dart';
import 'package:learningplatform_rb/providers/ExamProvider/exam_provider.dart';
class TeacherSingleChapter extends StatelessWidget {
  TeacherSingleChapter(this.chapter);
  final ChapterModel chapter;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Directionality(textDirection:TextDirection.rtl,
        child:Scaffold(
          appBar:UiConstans.appBar(size: size),
          body:ListView.builder(
            itemCount:chapter.lessons.length,
            itemBuilder:(BuildContext context,final int index){
              final LessonModel lesson=chapter.lessons[index];
              return SingleLesson(lesson);
            },
          ),
        ));
  }
}
class SingleLesson extends StatefulWidget {
  SingleLesson(this.lesson);
  final LessonModel lesson;
  @override
  _SingleLessonState createState() => _SingleLessonState();

}

class _SingleLessonState extends State<SingleLesson> {
  final RoyalLoading loading=RoyalLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(8.0),
      padding:const EdgeInsets.all(4.0),
      decoration:const BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.all(Radius.circular(40)),
          boxShadow:[
            BoxShadow(
                color:Colors.black26,
                blurRadius:9.0,
                spreadRadius:1.0
            )
          ]
      ),
      child: Column(
        children:[
          Text(widget.lesson.name,style:const TextStyle(color:Colors.brown,fontSize:16,fontWeight:FontWeight.bold),),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: [
              if(widget.lesson.exam!=null)RoyalRoundedButton("تصحيح الاجوبة",(){
                Navigator.push(context,RoyalNavigatorElasticInOut(AllAnswers(widget.lesson.exam,quick:true,),));
              },circular:15,),
              RoyalRoundedButton(widget.lesson.exam!=null?"حذف الامتحان":"انشاء امتحان",
                    ()async{
                  if(widget.lesson.exam!=null){
                    RoyalDialog.showMessage(context
                    ,message:"هل تريد حذف الامتحان فعلاً ؟",onAgree:(){
                      Navigator.pop(context);
                      deleteExam();
                        });
                  }else{
                    Navigator.push(context,RoyalNavigatorElasticInOut(CreateExam(widget.lesson.id,isPublicExam:false,onCreatingDone:(ExamModel exam){
                      widget.lesson.exam=exam;
                      setState(() {

                      });
                    },)));
                  }
                },
                circular:30,
                buttoncolor:widget.lesson.exam!=null?Colors.deepOrange:Colors.blue,
              ),

            ],
          ),

        ],
      )


    );
  }
  void deleteExam()async{
    loading.loading(context);
    final RS rs= await ExamProvider.removeQuickExam(widget.lesson.exam.id);
    if(rs.check()){
      widget.lesson.exam=null;
      setState(() {
      });
    }
    loading.cancel();
  }
}
