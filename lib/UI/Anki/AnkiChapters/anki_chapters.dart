import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Chapters/chapter.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/UI/Anki/AnkiElements/anki_elements.dart';
import 'package:learningplatform_rb/providers/AnkiElementProvider/anki_element_provider.dart';
class AnkiChapters extends StatefulWidget {
  AnkiChapters(this.subjectModel,{@required this.subject});
  final String subject;
  final SubjectModel subjectModel;
  @override
  _AnkiChaptersState createState() => _AnkiChaptersState();
}
class _AnkiChaptersState extends State<AnkiChapters> {
   AnkiChaptersProvider provider;
  @override
  void initState() {
    provider=AnkiChaptersProvider(id:widget.subject);
    provider.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Directionality(textDirection:TextDirection.rtl,
        child:Scaffold(
          appBar:AppBar(
            title:const Text('الفصول الدراسية'),
            centerTitle:true,
            toolbarHeight:size.height/9,
            shape:RoundedRectangleBorder(
              borderRadius:BorderRadius.vertical(bottom:Radius.elliptical(size.width,50))
            ),
          ),
          body:ValueListenableBuilder<List<ChapterModel>>(
            valueListenable:provider.notifier,
            child:const Center(child:CircularProgressIndicator(),),
            builder:(BuildContext context,List<ChapterModel> chapters,_){
              if(chapters==null){
                if(provider.loading.value==true)return _;
                else return const SizedBox();
              }
              if(chapters.isEmpty)return const RoyalEmptyData(message: "سيتم تزويد هذه المادة بالخدمة من الشركة",);
             return ListView.builder(
               itemCount:chapters.length,
               itemBuilder:(BuildContext context,int index){
                 final ChapterModel chapter=chapters[index];
                 return InkWell(
                   onTap:(){

                     Constans.jumpTo(context,AnkiElements(widget.subjectModel,chapter,chapterId:chapter.id,));
                     

                   },
                   borderRadius:BorderRadius.all(Radius.circular(30)),
                   child: Container(
                     padding:const EdgeInsets.all(8.0),
                     margin:const EdgeInsets.all(4.0),
                     decoration:const BoxDecoration(
                         
                         color:Colors.white,
                         borderRadius:BorderRadius.all(Radius.circular(30)),
                         boxShadow:[
                           BoxShadow(
                               color:Colors.black54,
                               spreadRadius:0.1,
                               blurRadius:1.0
                           )
                         ]
                     ),
                     child: Center(child:Text(chapter.name,textAlign:TextAlign.center,),),
                   ),
                 );
               },
             );
          },
          ),
        ));
  }
}
