import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/UI/Anki/AnkiChapters/anki_chapters.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';

class SingleAnkiSubjectUI extends StatelessWidget {
  final SubjectModel subject;
  final Function() onBought;
  SingleAnkiSubjectUI({@required this.subject,this.onBought,Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    bool free = subject.service.price == 0;
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow:[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                spreadRadius: 0.05
            )
          ]),
      child: Column(
        children: [
          Text(
            subject.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10,
          ),
       Container(
            padding: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.cyan),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "السعر : ",
                  style: const TextStyle(color: Colors.blueGrey),
                ),
                Text(
                  free ? "مجاناً" : subject.service.getPrice(),
                  style: const TextStyle(color: Colors.pink),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          free||subject.cart?.serviceId==subject.id
              ? RoyalRoundedButton(
                  "بدأ الآن",
                  () {
                    Navigator.push(context,MaterialPageRoute(builder:(BuildContext context)=>AnkiChapters(subject,subject:subject.id)));
                  },
                  circular: 20,
                buttoncolor:Colors.blue.shade300,
                )
              : RoyalRoundedButton(
                  "شراء",
                  () {
                    RoyalDialog.showMessage(context,message:"هل تريد فعلاً شراء آنكي مادة ${subject.name}  ؟",
                        onAgree:(){
                         Navigator.pop(context);
                         if(onBought!=null)onBought();
                        }
                    );
                  },
                  circular: 20,
                  buttoncolor: Colors.green,
                )
        ],
      ),
    );
  }

}


