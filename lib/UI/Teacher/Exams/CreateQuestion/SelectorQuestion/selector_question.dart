import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Handler/ExamsHandler/exam_handler.dart';
import 'package:learningplatform_rb/Handler/QuestionHandler/question_handler.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/UI/Teacher/Exams/CreateQuestion/ImageQuestion/image_question.dart';

class SelectorQuestion extends StatelessWidget {
  SelectorQuestion(this.questionHandler,this.eaxmHandler);
  final QuestionHandler questionHandler;
  final EaxmHandler eaxmHandler;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap:true,
      primary: false,
      children:[
        ImageQuestion(questionHandler,eaxmHandler),
        RoyalInputTextField("السؤال",questionHandler.title,maxLines:3,),
        const SizedBox(height:30,),
        const Center(child: Text('الاختيارات'),),
        ValueListenableBuilder<List<Options>>(valueListenable:questionHandler.options,
            child:const SizedBox(),
            builder:(BuildContext context,List<Options> value,child){
          if(value.isNotEmpty){
            return ListView.builder(
              primary: false,
              shrinkWrap:true,
              itemCount:value.length,
              itemBuilder:(BuildContext context,final int index){
                final Options op=value[index];
                return Directionality(
                  textDirection:TextDirection.rtl,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration:BoxDecoration(
                      border:Border.all(color:op.right==true?Colors.green:Colors.red),
                      borderRadius:BorderRadius.circular(25)
                    ),
                    child: ListTile(
                      title:Text(op.option,style:const TextStyle(fontSize:22),overflow:TextOverflow.ellipsis,),
                      trailing:IconButton(
                        icon: Icon(Icons.delete,color:Colors.red.shade300,),
                        onPressed: (){
                          questionHandler.options.value=List.from(questionHandler.options.value)..removeAt(index);
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return child;
            }),
        Align(child: RoyalRoundedButton("اضافة اختيار",(){
          dialog(context);
        },circular:30,buttoncolor:Colors.blue,)),
        const SizedBox(height:30,),

        Align(child: RoyalRoundedButton("انشاء سؤال",(){


          if(questionHandler.options.value.length<2){
            Constans.toast("يجب ان يكون هنالك على الاقل اختياران", false);
            return;
          }
          if(!Constans.checkTextInputs([questionHandler.mark])&&!Constans.isInteger(questionHandler.mark.text)){
            Constans.toast("يجب التاكد من قيمة درجة السؤال", false);
            return;
          }
          questionHandler.question.value.marks=questionHandler.mark.text;
          if(questionHandler.title.text.isNotEmpty){
            questionHandler.question.value.title=questionHandler.title.text;
            questionHandler.question.value.options=questionHandler.options.value;
            eaxmHandler.questionsList.value=List.from(eaxmHandler.questionsList.value)..add(questionHandler.question.value);
            Constans.toast("تم انشاء السؤال بنحاح",true);
            Navigator.pop(context);

          }else{
            Constans.toast("يرجى كتابة السؤال",false);
          }
        },circular:30)),
      ],
    );
  }
  void dialog(BuildContext context){
    final TextEditingController controller=TextEditingController();
    bool right=false;
    showDialog(context:context,
    builder:(BuildContext context){
      return StatefulBuilder(builder:(BuildContext context,setState){
        return Align(
          child:Container(
            padding: const EdgeInsets.all(10.0),
            margin:const EdgeInsets.all(10.0) ,
            decoration: const BoxDecoration(
                color:Colors.white,
                borderRadius:BorderRadius.all(Radius.circular(15))
            ),
            child:Material(
              child: Column(
                mainAxisSize:MainAxisSize.min,
                children:[
                  const SizedBox(height:20,),
                  RoyalInputTextField("اكتب الاختيار", controller),
                if(!questionHandler.isThereRightOption)Row(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoSwitch(value:right, onChanged:(v){
                        setState((){
                          right=v;
                        });
                      }),
                      Text('هل الاختيار اجابة صحيحة ؟'),
                    ],
                  ),
                  const SizedBox(height:20,),
                  RoyalRoundedButton("انشاء اختيار",(){
                    if(controller.text.isNotEmpty){
                      Constans.toast("تم انشاء اختيار بنجاح",true);
                    questionHandler.options.value=List.from(questionHandler.options.value)..add(Options(option:controller.text,right:right));
                    Navigator.pop(context);
                    }else{
                      Constans.toast("يرجى كتابة الاختيار", false);
                    }
                  },circular:25,)
                ],
              ),
            ),
          ),
        );
      });
    }
    );
  }
}
