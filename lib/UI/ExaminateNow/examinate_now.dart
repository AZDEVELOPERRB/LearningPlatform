import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Handler/AnswerHandler/answer_handler.dart';
import 'package:learningplatform_rb/Models/Answer/answer_model.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/Models/QuestionModel/question_model.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/Answers/NormalAnswer/normal_answer.dart';
import 'package:learningplatform_rb/UI/Answers/SelectAnswer/select_answer.dart';
import 'package:learningplatform_rb/UI/Exam/ExamTimer/exam_timer.dart';
import 'package:learningplatform_rb/UI/OptionsUI/option_ui.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
import 'package:learningplatform_rb/UI/SingleExam/single_exam.dart';
// ignore: must_be_immutable
class ExaminateNow extends StatelessWidget {
  ExaminateNow(this.examModel,{this.onQuestionClicked,this.showOptions}):
  answerHandler=AnswerHandler(examModel);
  final ExamModel examModel;
  final bool showOptions;
  final Function(QuestionModel question) onQuestionClicked;
   AnswerHandler answerHandler;
  final GlobalKey timerKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar:UiConstans.appBar(size:size),
      body:Stack(
        children: [
          ListView(
            children:[
            if(examModel.hasRight)const SizedBox(height:60,)else const SizedBox(height:25),
              if(examModel.result!=null)Center(
                child:Container(
                  padding:const EdgeInsets.all(8.0),
                decoration:BoxDecoration(
                  border:Border.all(color:Colors.green),
                  borderRadius:BorderRadius.all(Radius.circular(15))
                ),
                child: Text(examModel.result.toString() +"  درجتك  ",style:const TextStyle(
                  color:Colors.brown,
                  fontSize: 15,fontWeight:FontWeight.w900,),textAlign:TextAlign.center,),
              ),),
              Center(child:Text(examModel.name,style:const TextStyle(fontSize: 22,fontWeight:FontWeight.bold,),textAlign:TextAlign.center,),),
              ListView.builder(
                itemCount:examModel.questions.length,
                primary: false,
                shrinkWrap:true,
                itemBuilder:(BuildContext context,final int index ){
                  final QuestionModel question=examModel.questions[index];
                  return Container(
                    margin:const EdgeInsets.all(8.0),
                    padding:const EdgeInsets.all(10.0),
                    decoration:const BoxDecoration(
                        color:Colors.white,
                        borderRadius:BorderRadius.all(Radius.circular(15)),
                        boxShadow:[
                          BoxShadow(
                              color:Colors.black12,
                              blurRadius:9.0,
                              spreadRadius:1.0)
                        ]
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:3.0),
                          child: Row(
                            textDirection:TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('السؤال رقم : '+(index+1).toString(),style:const TextStyle(fontWeight:FontWeight.bold),),
                              Column(
                                children: [
                                  Text(question.marks??"",style: TextStyle(color: Colors.brown,fontSize:11),textAlign:TextAlign.right,),
                                  const Text("درجة",style: TextStyle(color: Colors.brown,fontSize:11),textAlign:TextAlign.right,)
                                ],
                              ),
                            ],
                          ),
                        ),
                       if(question.images!=null&&question.images.isNotEmpty)RoyalCacheImage(question.images?.first?.url??"",
                          width:size.width,height:size.height/3,),
                        if(question.title!=null) SizedBox(
                          width:size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:5.0),
                            child: Text(question?.title,textAlign:TextAlign.right,
                              style:const TextStyle(color:Colors.brown),
                              textDirection:TextDirection.rtl,),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        if(question.type?.id=="select"&&showOptions!=null&&showOptions==true)Text('الاختيارات'),
                        if(question.type?.id=="select"&&showOptions!=null&&showOptions==true)OptionsUi(question),
                        const SizedBox(height:10,),
                      if(examModel.hasRight)ValueListenableBuilder<AnswerModel>(valueListenable:question.answer,
                       builder:(BuildContext context,AnswerModel answer,child){
                         return RoyalRoundedButton(answer!=null?"تمت الاجابة":"اجابة على هذا السؤال",(){
                           Widget child;
                           if(question.type.id=="normal")child=NormalAnswer(question);
                           if(question.type.id=="select")child=SelectAnswer(question);
                           RoyalDialog.publicDialog(context,child??const SizedBox(),height:size.height/1.4);
                         },circular:30,buttoncolor:answer!=null?Colors.green:Colors.blue,);
                       },)
                      ],
                    ),
                  );
                },
              ),
              if(examModel.hasRight)Align(child:RoyalRoundedButton(
                "ارسال الاجابات الآن",
                    (){
                  answerHandler.sendAnswers(context,onExamCorrected:(int result){
                    examModel.result=result;
                    examModel.done=true;
                    answerHandler.exam.result=result;
                    answerHandler.exam.done=true;
                   RoyalDialog.showMessage(context,
                   child:Column(
                     mainAxisAlignment:MainAxisAlignment.spaceAround,
                     children:[
                       Text(' % نتيجتك في الامتحان هي  $result '),
                       Row(
                         mainAxisAlignment:MainAxisAlignment.spaceAround,
                         children: [
                           RoyalRoundedButton("موافق",(){
                             Navigator.pop(context);
                             Navigator.pop(context);
                             Navigator.pop(context);
                           },circular:15,),
                           RoyalRoundedButton("اظهر لي الاجوبة",(){
                             Navigator.pop(context);
                             Navigator.pop(context);

                             Navigator.pushReplacement(context, RoyalNavigatorElasticInOut(SingleExam(answerHandler.exam,isTeacher:false,)));
                           },circular:15,),
                         ],
                       )
                     ],
                   ));
                  });
              },
                circular:30,buttoncolor:Colors.brown,
              )),
              const SizedBox(height:20,),
               Container(
                padding:const EdgeInsets.all(8.0),
                 margin:const EdgeInsets.symmetric(horizontal:15),
                 decoration:BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.circular(20)),
                   border:Border.all(color:Colors.blue)
                 ),
                 child:Center(child:Text(
                   "الامتحان من ${examModel.totalExamDegrees}  درجة "+
                     "\n"
                     "يعاد الامتحان عندما تكون درجتك اقل من   ${examModel.minimumDegree}",textAlign:TextAlign.center
                   ,style:const TextStyle(color:Colors.brown)
                   ,),),
              ),
              const SizedBox(height:20,),
            ],
          ),
         if(examModel.hasRight) Align(
            alignment:const Alignment(-0.99,-0.98),
            child:ExamTime(examModel,answerHandler,key:timerKey,),
          )
        ],
      ),
    );
  }

}

