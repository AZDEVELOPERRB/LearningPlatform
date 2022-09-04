import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/UI/Anki/AnkiSubjects/single_anki_subject_ui.dart';
import 'package:learningplatform_rb/providers/AnkiSubjectsProvider/anki_subjects_provider.dart';
class AnkiSubjects extends StatefulWidget {
  @override
  _AnkiSubjectsState createState() => _AnkiSubjectsState();
}
class _AnkiSubjectsState extends State<AnkiSubjects> {
  final AnkiSubjectsProvider ankiSubjectsProvider=AnkiSubjectsProvider();
  @override
  void initState() {
    ankiSubjectsProvider.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:TextDirection.rtl,
      child: ValueListenableBuilder<List<SubjectModel>>(valueListenable:ankiSubjectsProvider.notifier,
          child:const SizedBox(),
          builder:(BuildContext context,List<SubjectModel> value,_){
        if(value==null){
          if(ankiSubjectsProvider.loading.value==true)return const Center(child:  CircularProgressIndicator());
        }
        if(value is List){
          if(value.isEmpty)return RoyalEmptyData(message:"سيتم توفيرها قريباً",);
          return ListView.builder(
            itemCount:value.length,
            itemBuilder:(BuildContext context,int index){
              print(index);
              final SubjectModel subject=value[index];
              return SingleAnkiSubjectUI(subject:subject,onBought:(){
                ankiSubjectsProvider.buy(context,subject.id);
              },key:UniqueKey(),);
            },
          );
        }
        return _;
          }),
    );
  }
}
