import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Handler/ExamsHandler/exam_handler.dart';
import 'package:learningplatform_rb/Handler/QuestionHandler/question_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
class ImageQuestion extends StatefulWidget {
  ImageQuestion(this.questionHandler,this.eaxmHandler);
  final QuestionHandler questionHandler;
  final EaxmHandler eaxmHandler;
  @override
  _ImageQuestionState createState() => _ImageQuestionState();
}

class _ImageQuestionState extends State<ImageQuestion> {
   File image;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return ListView(
      shrinkWrap:true,
      primary: false,
      children: [
        IconButton(
          icon:const Icon(Icons.add_a_photo,size:40,color:Colors.amber,),
          onPressed:pickImage,
        ),
        const SizedBox(height:20,),
        image!=null?Image.asset(image.path,width:size.width,fit:BoxFit.fill,)
            :const SizedBox(),        const SizedBox(height:20,),
      ],
    );
  }
  void pickImage()async{
    final PickedFile file=await ImagePicker().getImage(source:ImageSource.gallery,maxHeight: 1000,maxWidth: 1000);
    final String base64=base64Encode(await file.readAsBytes());
    final String extension=file.path.split("/").last;
    widget.questionHandler.question.value.base64=base64;
    widget.questionHandler.question.value.extension=extension;
    setState(() {
      image=File(file.path);
    });
  }
}
