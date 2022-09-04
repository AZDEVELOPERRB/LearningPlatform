import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Answer/answer_model.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/Models/QuestionModel/question_model.dart';
import 'package:learningplatform_rb/UI/OptionsUI/option_ui.dart';

class SelectAnswer extends StatefulWidget {
  SelectAnswer(this.question);
  final QuestionModel question;
  @override
  _SelectAnswerState createState() => _SelectAnswerState();
}
class _SelectAnswerState extends State<SelectAnswer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children:[
          OptionsUi(widget.question,onClick:(Options option){
            final AnswerModel answer=AnswerModel(
                type:widget.question.type,
                questionId:widget.question.id,
                selectedOption:option
            );
            widget.question.answer.value=answer;
            Constans.toast("تمت الاجابة بنجاح",true);
            Navigator.pop(context);
          },)
        ],
      ),
    );
  }
}
