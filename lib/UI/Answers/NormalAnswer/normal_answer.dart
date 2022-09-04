import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Answer/answer_model.dart';
import 'package:learningplatform_rb/Models/QuestionModel/question_model.dart';
import 'package:learningplatform_rb/UI/Answers/ImageAnswer/image_answer.dart';
class NormalAnswer extends StatefulWidget {
  NormalAnswer(this.question);
  final QuestionModel question;
  @override
  _NormalAnswerState createState() => _NormalAnswerState();
}
class _NormalAnswerState extends State<NormalAnswer> {
  final TextEditingController title=TextEditingController();
  final RoyalImagePicker _picker=RoyalImagePicker();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.min,
        children: [
          space,
          ImageAnswer(widget.question,_picker),
          space,
          RoyalInputTextField("الاجابة", title,maxLines: 6,),
          space,
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: [
              RoyalRoundedButton("رجوع",(){Navigator.pop(context);},circular: 30,),
              RoyalRoundedButton("اجابة",() async {



                ///  The Text controller Checker
                if(title.text==null||title.text==""){Constans.toast("يجب كتابة الاجابة", false);return;}
              final  AnswerModel answer=AnswerModel(title:title.text,type:widget.question.type,questionId:widget.question.id);
                if(_picker.image!=null){
                  Uint8List imageBytes=await _picker.image.readAsBytes();
                  final String base64 =base64Encode(imageBytes);
                  final String extension=_picker.image.path.split('/').last.split('.').last;
                  answer.base64=base64;
                  answer.extension=extension;
                }
                widget.question.answer.value=answer;
                Constans.toast("تمت الاجابة على السؤال",true);
                Navigator.pop(context);
                },
                circular:30,buttoncolor:Colors.blue,),
            ],
          ),
        ],
      ),
    );
  }
  final SizedBox space= const SizedBox(height:30,);
}

