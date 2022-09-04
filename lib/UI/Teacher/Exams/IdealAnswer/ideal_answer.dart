import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/IdealAnswer/ideal_answer.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/UI/Answers/ImageAnswer/image_answer.dart';
class IdealAnswerUI extends StatefulWidget {
  IdealAnswerUI(this.question);
  final Question question;
  @override
  _NormalAnswerState createState() => _NormalAnswerState();
}
class _NormalAnswerState extends State<IdealAnswerUI> {
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
          IdealImageAnswer(widget.question,_picker),
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
                final  IdealAnswer answer=IdealAnswer(title:title.text,examType:widget.question.type);
                if(_picker.image!=null){
                  Uint8List imageBytes=await _picker.image.readAsBytes();
                  final String base64 =base64Encode(imageBytes);
                  final String extension=_picker.image.path.split('/').last.split('.').last;
                  answer.base64=base64;
                  answer.extension=extension;
                }
                widget.question.idealAnswer=answer;
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

