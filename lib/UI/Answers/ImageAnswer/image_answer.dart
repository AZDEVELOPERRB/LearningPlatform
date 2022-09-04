import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/Models/QuestionModel/question_model.dart';

class ImageAnswer extends StatefulWidget {
  ImageAnswer(this.question,this.picker);
  final QuestionModel question;
  final RoyalImagePicker picker;
  @override
  _ImageAnswerState createState() => _ImageAnswerState();
}
class _ImageAnswerState extends State<ImageAnswer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          widget.picker
        ],
      ));
  }
  final SizedBox space=SizedBox(height:20,);

}

class IdealImageAnswer extends StatefulWidget {
  IdealImageAnswer(this.question,this.picker);
  final Question question;
  final RoyalImagePicker picker;
  @override
  _IdealImageAnswerState createState() => _IdealImageAnswerState();
}
class _IdealImageAnswerState extends State<IdealImageAnswer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            widget.picker
          ],
        ));
  }
  final SizedBox space=SizedBox(height:20,);

}