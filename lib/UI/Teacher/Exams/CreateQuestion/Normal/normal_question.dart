import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Handler/ExamsHandler/exam_handler.dart';
import 'package:learningplatform_rb/Handler/QuestionHandler/question_handler.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
import 'package:learningplatform_rb/UI/Teacher/Exams/CreateQuestion/ImageQuestion/image_question.dart';
import 'package:learningplatform_rb/UI/Teacher/Exams/IdealAnswer/ideal_answer.dart';
class NormalQuestion extends StatelessWidget {
   NormalQuestion(this.questionHandler,this.eaxmHandler);
  final QuestionHandler questionHandler;
  final EaxmHandler eaxmHandler;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap:true,
      primary: false,
      children: [
        ImageQuestion(questionHandler,eaxmHandler),
            RoyalInputTextField("عنوان السؤال", questionHandler.title,maxLines:3,),
        const SizedBox(height:20,),
        Align(
          child: RoyalRoundedButton("الاجابة المثالية للسؤال",(){
            RoyalDialog.publicDialog(context,
            IdealAnswerUI(questionHandler.question.value)
            );
          },circular:20,buttoncolor:Colors.red.shade300,),
        ),
        Align(
          child: RoyalRoundedButton(
              "انشاء سؤال",
                  (){
                if(questionHandler.title.text.isNotEmpty){
                  questionHandler.question.value.title=questionHandler.title.text;
                  if(!Constans.checkTextInputs([questionHandler.mark])&&!Constans.isInteger(questionHandler.mark.text)){
                    Constans.toast("يجب التاكد من قيمة درجة السؤال", false);
                    return;
                  }
                  if(questionHandler.question.value.idealAnswer==null){
                    Constans.toast("يجب انشاء جواب مثالي لبقية المدرسين", false);
                    return;
                  }
                  questionHandler.question.value.marks=questionHandler.mark.text;
                  eaxmHandler.questionsList.value=List.from(eaxmHandler.questionsList.value)..add(questionHandler.question.value);
                  Constans.toast("تم انشاء سؤال بنجاح",true);
                  Navigator.pop(context);
                }else{
                  Constans.toast("يجب اكمال الحقول",false);
                }
              },
              circular:25,buttoncolor:Colors.blue,),
        ),

      ],
    );
  }
}
