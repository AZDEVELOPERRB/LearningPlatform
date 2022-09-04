import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/Models/QuestionModel/question_model.dart';
class OptionsUi extends StatefulWidget {
  OptionsUi(this.question,{this.onClick,this.showHint});
  final QuestionModel question;
  final bool showHint;
  final Function(Options option) onClick;

  @override
  _OptionsUiState createState() => _OptionsUiState();
}

class _OptionsUiState extends State<OptionsUi> {
  Options selectedOption;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return GridView.count(
      shrinkWrap:true,
      crossAxisCount:2,children:List.generate(widget.question.options.length,
            (index){
          final Options option=widget.question.options[index];
          return Align(
            child: InkWell(
              onTap:(){
                if(widget.onClick!=null){
                  widget.onClick(option);
                  setState(() {
                    selectedOption= option;
                  });
                }
              },
              child: Center(
                child: Container(
                  width:size.width/2.2,
                  margin:const EdgeInsets.all(8.0),
                  padding:const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: selectedOption!=null&&selectedOption==option?Colors.brown:Colors.white,
                      border:Border.all(color:widget.showHint!=null&&widget.showHint==true?option.right?Colors.green:Colors.black:selectedOption!=null&&selectedOption==option?Colors.white:Colors.black),
                      borderRadius:BorderRadius.all(Radius.circular(20))
                  ),
                  child: Text(option.option??"",
                    style:TextStyle(color:selectedOption!=null&&selectedOption==option?Colors.white:Colors.black),

                  textAlign:TextAlign.center,),
                ),
              ),
            ),
          );
        }),);
  }
}
