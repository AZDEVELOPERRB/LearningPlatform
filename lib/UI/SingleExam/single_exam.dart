import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Handler/CorrectQuestionsHandler/correct_questions_handler.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/Models/QuestionModel/question_model.dart';
import 'package:learningplatform_rb/UI/Answers/IdealAnswer/ideal_answer.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';

class SingleExam extends StatefulWidget {
  SingleExam(this.examModel,{this.onQuestionClicked,this.answersHint,this.handler,this.onResultComplete,this.isTeacher=true});
  final ExamModel examModel;
  final bool answersHint;
  final CorrectQuestionsHandler handler;
  final Function(QuestionModel question) onQuestionClicked;
  final Function (int result) onResultComplete;
  final bool isTeacher;
  @override
  _SingleExamState createState() => _SingleExamState();
}
class _SingleExamState extends State<SingleExam> {

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar:UiConstans.appBar(size:size),
      body:ListView(
        children:[
          Center(child:Text(widget.examModel.name,style:const TextStyle(fontSize: 22,fontWeight:FontWeight.bold),),),
          ListView.builder(
            itemCount:widget.examModel.questions.length,
            primary: false,
            shrinkWrap:true,
            itemBuilder:(BuildContext context,final int index ){
              final QuestionModel question=widget.examModel.questions[index];
              return Container(
                margin:const EdgeInsets.all(8.0),
                padding:const EdgeInsets.all(10.0),
                decoration:const BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.all(Radius.circular(15)),
                  boxShadow:[
                    BoxShadow(color:Colors.black12, blurRadius:9.0, spreadRadius:1.0)
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
                          Text('السؤال رقم : '+(index+1).toString(),style:const TextStyle(fontWeight:FontWeight.w900,color:Colors.brown),),
                          if(question.answer?.value!=null)ValueListenableBuilder<int>(valueListenable:question.answer?.value?.result,
                              child:const SizedBox(),
                              builder:(BuildContext context,int value,child){
                            if(value==null)return child;
                            return Text(" درجته "+value.toString()??"",
                              style: TextStyle(color: Colors.indigo,fontSize:11,fontWeight:FontWeight.w900)
                              ,textDirection:TextDirection.rtl,);
                              })
                        ],
                      ),
                    ),



                    if(question.images?.first?.url!=null)RoyalCacheImage(question.images?.first?.url??"",
                     width:size.width,takeRequiredSpace:true,),
                    const SizedBox(height:10,),
                    SizedBox(
                      width:size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: Text(question?.title,textAlign:TextAlign.right,style:const TextStyle(
                          color:Colors.brown,
                          fontSize:15
                        ),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    if(question.type?.id=="select")const Text('الاختيارات'),
                    if(question.type?.id=="select")GridView.count(
                      shrinkWrap:true,
                      primary:false,
                      crossAxisCount:2,children:List.generate(question.options.length,
                            (index){
                          final Options option=question.options[index];
                          return Align(
                            child: Center(
                              child: Container(
                                  width:size.width/2.2,
                                  margin:const EdgeInsets.all(8.0),
                                  padding:const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                    border:Border.all(color:widget.answersHint!=null||question.answer.value!=null?option.right?Colors.green:Colors.red:Colors.black),
                                    borderRadius:BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: Text(option.option??"",
                                  textAlign:TextAlign.center,),),
                            ),
                          );
                        }),),

                    if(question.answer.value!=null) SizedBox(
                      width:size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: Text("جواب الطالب :",textAlign:TextAlign.right,textDirection:TextDirection.rtl,
                          style:const TextStyle(color:Colors.brown,fontWeight: FontWeight.w900),),
                      ),
                    ),

                    if(question.answer.value!=null&&question.type.id=="select") Container(
                      padding: const EdgeInsets.all(10.0),
                      margin:const EdgeInsets.symmetric(horizontal:20,),
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(20)),
                        border:Border.all(color:Colors.brown)
                      ),
                      child:Center(
                        child:Text(question.answer.value.selectedOption.option,style:const TextStyle(color:Colors.brown),),
                      ),
                    ),
                    if(question.answer?.value?.images?.first?.url!=null)RoyalCacheImage(question.answer?.value?.images?.first?.url??"",
              width:size.width,
                      takeRequiredSpace: true,
                    fit:BoxFit.fill,),
                    const SizedBox(height: 20,),
                    if(question.answer.value!=null&&question.type.id=="normal") SizedBox(
                      width:size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: Text(question?.answer?.value?.title,textAlign:TextAlign.right,
                          style:const TextStyle(color:Colors.brown,fontWeight: FontWeight.w900),),
                      ),
                    ),
                   if(question.answer.value!=null&&question.answer.value?.result?.value==null&&question.type.id!="select"&&widget.isTeacher==true) Row(
                     mainAxisAlignment:MainAxisAlignment.spaceAround,
                     children: [
                       RoyalRoundedButton("الجواب النموذجي", (){
                        RoyalDialog.publicDialog(context,IdealAnswerTeacher(question.idealAnswer));
                       },circular:20,buttoncolor:Colors.orange,),
                       RoyalRoundedButton(question.answer.value?.result?.value!=null?"تم تصحيح السؤال":"تقييم جوابه",
                              (){
                           TextEditingController result=TextEditingController();
                          if(question.answer.value.result.value!=null){
                            result=TextEditingController(text:question.answer.value.result.value.toString());
                          }
                          RoyalDialog.publicDialog(context,
                          SingleChildScrollView(
                            child: Column(
                              children:[
                                 Text(' السؤال من '+question.marks +"  درجة  ",textAlign:TextAlign.right,style:const TextStyle(color:Colors.green,fontWeight:FontWeight.bold),),
                                RoyalInputTextField("درجته", result,inputType:TextInputType.phone,),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                                  children: [
                                    RoyalRoundedButton("رجوع",(){
                                      Navigator.pop(context);
                                    },circular:20,buttoncolor:Colors.red.shade300,),
                                    RoyalRoundedButton("تقييم", (){
                                      final int counteredValue=int.parse(result.text);
                                      if(counteredValue<=int.parse(question.marks)){
                                        question?.answer?.value?.result?.value=counteredValue;
                                        Constans.toast("تم تصحيح السؤال",true);
                                        Navigator.pop(context);
                                      }else{
                                        Constans.toast(
                                            "الدرجة المعطاة اكثر من درجة السؤال",
                                            false);
                                      }
                                    },circular: 15,

                                    ),

                                  ],
                                )
                              ],
                            ),
                          )
                          );
                        },circular:20,buttoncolor:question.answer?.value?.result?.value!=null?Colors.green:Colors.black45,),
                     ],
                   )
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 3,),
        if(widget.handler!=null&&widget.handler.customerAnswer?.result==null)Align(
            child: RoyalRoundedButton("تصحيح الامتحان الآن", (){

              widget.handler.correctExam(context,onResultComplete: widget.onResultComplete);
            },circular:20,buttoncolor:Colors.blue,),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
