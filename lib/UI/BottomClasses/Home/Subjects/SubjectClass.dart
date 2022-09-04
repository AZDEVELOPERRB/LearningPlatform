import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Home/Subjects/SingleSubjectView.dart';
import 'package:learningplatform_rb/providers/SubjectsProvider/subject_provider.dart';

class SubjectsClass extends StatefulWidget {
  @override
  _SubjectsClassState createState() => _SubjectsClassState();
}
class _SubjectsClassState extends State<SubjectsClass> {
  final SubjectProvider provider=SubjectProvider();
  @override
  void initState() {
    provider.getSubjects();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height/4,
      child: Stack(
        children: [
          ValueListenableBuilder(valueListenable:provider.subjectsNotifier,
            builder:(BuildContext context,List value,_){
              if(provider.subjects==null)return const SizedBox();
              if(provider.subjects.isEmpty)return const RoyalEmptyData();
              return ListView.builder(
                reverse: true,
                itemCount:provider.subjects.length,
                scrollDirection:Axis.horizontal,
                itemBuilder:(c,i){
                  return singleSubject(provider.subjects[i],size);
                },
              );
            },
          ),
          ValueListenableBuilder<bool>(valueListenable:provider.loading,
              child:Align(alignment:Alignment.bottomCenter,child: LinearProgressIndicator()),
              builder:(BuildContext context,bool value,child){
                if(value==false
                || value==true && provider.subjectsNotifier.value!=null && provider.subjectsNotifier.value.isNotEmpty
                )return const SizedBox();

                return child;
              })
        ],
      ),
    );
  }
  Widget singleSubject(SubjectModel subjectModel,Size size){
    return InkWell(
      key:UniqueKey(),
      onTap:(){
        if(subjectModel.chapters.length==0){
          Constans.toast("لا تحتوي هذه المادة على فصول",false);
          return;
        }
        Navigator.push(context,RoyalNavigatorElasticInOut(SingleSubjectClass(subjectModel)));
      },
      child: Padding(padding: const EdgeInsets.all(8),
        child:Container(
          width: size.width/3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.yellow.shade100,
              boxShadow:[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset:const Offset(0, 3), // changes position of shadow
                ),
              ]

          ),
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children:[
                Expanded(child: CachedNetworkImage(imageUrl:Api.image+subjectModel.image.path,
                fit:BoxFit.fill,
                progressIndicatorBuilder:(c,s,p){
                  return const Center(
                    child:SizedBox(
                      height:20,
                      width: 20,
                      child: CircularProgressIndicator(backgroundColor:Colors.white,),
                    ),
                  );
                },
                )),
                const SizedBox(height:3,),
                Text(subjectModel.name,style:const TextStyle(fontSize: 12,color: Colors.brown,fontWeight:FontWeight.bold),),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
