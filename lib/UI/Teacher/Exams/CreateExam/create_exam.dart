import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Handler/ExamsHandler/exam_handler.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/Teacher/Exams/CreateQuestion/create_question.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
class CreateExam extends StatelessWidget {
  CreateExam(this.subjectId,{this.isPublicExam=true,this.onCreatingDone}):handler=EaxmHandler(subjectId);
  final String subjectId;
  final EaxmHandler handler;
  final bool isPublicExam;
  final Function(ExamModel examModel) onCreatingDone;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return
      Scaffold(
        floatingActionButtonLocation:FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton:RoyalRoundedButton(
          "انشاء امتحان",
              (){
            showDialog(context:context,
            builder:(BuildContext alertContext){
              return Align(
                child: Scaffold(
                  backgroundColor:Colors.transparent,
                  body:Center(
                    child: Container(
                      height:size.height/1.6,
                      margin:const EdgeInsets.all(8.0),
                      padding:const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color:Colors.white,
                        border:Border.all(color:Colors.black26),
                        borderRadius:BorderRadius.all(Radius.circular(25))
                      ),
                      child:ListView(
                        children:[
                          RoyalAppLogo(),
                          const SizedBox(height:30,),
                          RoyalInputTextField("اسم الامتحان",handler.examName),
                          RoyalInputTextField("وقت الامتحان بالدقائق",handler.examTime),
                          const SizedBox(height:20,),
                          Align(
                            child: RoyalRoundedButton("انشاء الامتحان الآن",(){
                              if(handler.validator()){
                                Navigator.pop(alertContext);
                                handler.createExam(context,isPublicExam:isPublicExam,onCreatingDone:onCreatingDone);
                              }
                            },circular:30,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
               },
          circular:30,),
        appBar: AppBar(
          toolbarHeight:70,
          backgroundColor:Colors.blue.withOpacity(0.5),
          centerTitle:true,
          elevation:4,
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.vertical(
              bottom:Radius.elliptical(size.width, 56.0),
            ),
          ),
        ),
        body:ListView(
          children:[
          ValueListenableBuilder<List<Question>>(
            valueListenable:handler.questionsList,
            child: const  Center(child: Text('لا توجد اسئلة')),
            builder:(BuildContext context,List<Question> questions,child){
              if(questions.isNotEmpty){
                return ListView.builder(
                  shrinkWrap:true,
                  primary:false,
                  itemCount:questions.length,
                  itemBuilder: (BuildContext context,final int index){
                    final Question q=questions[index];
                    return Directionality(
                      textDirection:TextDirection.rtl,
                      child:Padding(
                        padding:const EdgeInsets.all(8.0) ,
                        child: Container(
                          decoration: BoxDecoration(
                              border:Border.all(color:Colors.black26),
                              borderRadius:BorderRadius.circular(15)
                          ),
                          child: ListTile(
                            title: Text("السؤال رقم "+(index+1).toString()) ,
                            subtitle:q.type.id=="image"?Text('سؤال صوري'):Text(q.title,overflow:TextOverflow.ellipsis,),
                            trailing: IconButton(
                              icon: Icon(Icons.delete,color:Colors.red.shade300,),
                              onPressed:(){
                                handler.questionsList.value=List.from(handler.questionsList.value)..removeAt(index);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            return child ;
            },
          ),
            const SizedBox(height:12,),
            FloatingActionButton(onPressed: (){
              Navigator.push(context,RoyalNavigatorElasticInOut(CreateQuestion(handler)));
            },child:const Icon(Icons.add),)
          ],
        ),
      );
  }
}
