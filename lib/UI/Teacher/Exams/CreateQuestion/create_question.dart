import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Handler/ExamsHandler/exam_handler.dart';
import 'package:learningplatform_rb/Handler/QuestionHandler/question_handler.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/UI/Teacher/Exams/CreateQuestion/Normal/normal_question.dart';
import 'package:learningplatform_rb/UI/Teacher/Exams/CreateQuestion/SelectorQuestion/selector_question.dart';

class CreateQuestion extends StatelessWidget {
  final EaxmHandler handler;
  CreateQuestion(this.handler);
  final QuestionHandler questionHandler=QuestionHandler();
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return   Scaffold(
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
          RoyalInputTextField("درجة السؤال", questionHandler.mark,inputType:TextInputType.phone,),
          const SizedBox(height:20,),
          QuestionTypeSelector(questionHandler),
         ValueListenableBuilder<Question>(
             valueListenable:questionHandler.question,
             builder:(BuildContext context,Question question,_){
               print(question?.type?.id);
               if(question?.type?.id=="normal"){
                 return NormalQuestion(questionHandler,handler);
               }
               if(question?.type?.id=="select"){
                 return SelectorQuestion(questionHandler,handler);
               }
               return const SizedBox();
             }),


        ],
      ),
    );
  }
}

















class QuestionTypeSelector extends StatefulWidget {
  final QuestionHandler questionHandler;
  QuestionTypeSelector(this.questionHandler);
  @override
  _QuestionTypeSelectorState createState() => _QuestionTypeSelectorState();
}

class _QuestionTypeSelectorState extends State<QuestionTypeSelector> {
  ExamType examType;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        isExpanded: true,
        hint:Center(child:Text('يرجى اختيار نوع السؤال'),),
        items: [
          for (final ExamType etype in Constans.examTypes)DropdownMenuItem(
              value:etype,
              child: Center(
                  child: Text(etype.name,textAlign:TextAlign.center,)))
        ],
        value:examType,
        onChanged:(v){
          widget.questionHandler.question.value=Question(type:v);
          setState(() {
            examType=v;
          });
        });
  }
}
