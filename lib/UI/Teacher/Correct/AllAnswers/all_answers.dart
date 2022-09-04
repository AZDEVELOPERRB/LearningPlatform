import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Handler/CorrectQuestionsHandler/correct_questions_handler.dart';
import 'package:learningplatform_rb/Models/CustomerAnswer/customer_answer.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/SingleExam/single_exam.dart';
import 'package:learningplatform_rb/providers/AllAnswerProvider/all_answers_provider.dart';
class AllAnswers extends StatefulWidget {
  AllAnswers(this.exam,{final bool quick=false}):answersProvider=AllAnswersProvider(exam.id,quick:quick);
  final ExamModel exam;
  final AllAnswersProvider answersProvider;
  @override
  _AllAnswersState createState() => _AllAnswersState();
}

class _AllAnswersState extends State<AllAnswers> {

  @override
  void initState() {
    widget.answersProvider.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:70,
        backgroundColor:Colors.blue.withOpacity(0.5),
        centerTitle:true,
        elevation:4,
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.vertical(
            bottom:Radius.elliptical(size.width, 55.0),
          ),
        ),
      ),
      body:Stack(
        children:[
          ValueListenableBuilder<List<CustomerAnswer>>(valueListenable:widget.answersProvider.allAnswers,
              child:const SizedBox(),
              builder:(BuildContext context,List<CustomerAnswer> answers,child){
            if(answers==null)return child;
            if(answers.isEmpty)return const RoyalEmptyData(message:"لا توجد اجوبة",);
            return ListView.builder(
              itemCount:answers.length,
              itemBuilder:(BuildContext context,final int index){
                final CustomerAnswer answer=answers[index];
                return Container(
                  width: size.width,
                  margin: const EdgeInsets.symmetric(vertical:8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration:const BoxDecoration(
                    color:Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:Colors.black12,
                        blurRadius:9.0,
                        spreadRadius: 1.0
                      )
                    ]
                  ),
                  child:Directionality(
                      textDirection:TextDirection.rtl,
                      child: ListTile(
                        title: Text(answer.student.name,textDirection:TextDirection.rtl,),
                        subtitle:const Text("اسم الطالب  "),
                        trailing: RoyalRoundedButton(answer.result!=null?"تم تصحيح جوابه":"تصحيح جوابه",(){
                          final CorrectQuestionsHandler handler=CorrectQuestionsHandler(answer);
                          Navigator.push(context, RoyalNavigatorElasticInOut(SingleExam(answer.exam,handler:handler,
                          onResultComplete:(int result){
                          widget.answersProvider.answerCorrected(answer.id,result);
                          },)));
                        },circular:25,buttoncolor:answer.result!=null?Colors.green:Colors.black54,),
                      )),
                );
              },
            );
              }),
          ValueListenableBuilder<bool>(valueListenable:widget.answersProvider.loading,
              child:const SizedBox(),
              builder:(BuildContext context,bool load,child){
                if(load==true) return  const RoyalLoadingLinear();
                if(load==false&&widget.answersProvider?.pagination?.next!=null)return  Align(
                  alignment:const Alignment(-0.9,0.95),
                  child: RoyalRoundedButton("تحميل المزيد",(){widget.answersProvider.init();},circular:35,),);
                return child;
              })
        ],
      ),
    );
  }
}
