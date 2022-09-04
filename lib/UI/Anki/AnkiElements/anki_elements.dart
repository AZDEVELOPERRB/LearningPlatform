import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/AnkiElement/anki_question.dart';
import 'package:learningplatform_rb/Models/Chapters/chapter.dart';
import 'package:learningplatform_rb/Models/Subject/subject_model.dart';
import 'package:learningplatform_rb/UI/Anki/AnkiQuestions/anki_questions.dart';
import 'package:learningplatform_rb/providers/AnkiElementProvider/anki_element_provider.dart';
class AnkiElements extends StatefulWidget {
  final String chapterId;
  final SubjectModel subject;
  final ChapterModel chapter;
  AnkiElements(this.subject,this.chapter,{@required this.chapterId});

  @override
  _AnkiElementsState createState() => _AnkiElementsState();
}
class _AnkiElementsState extends State<AnkiElements> {
   AnkiElementsProvider provider;
   AnkiElementsProvider learningMode;
   AnkiElementsProvider timeMode;

  @override
  void initState() {
    provider=AnkiElementsProvider(widget.subject,widget.chapter,id:widget.chapterId);
    provider.init();
    /// init The Taps Providers
    learningMode=AnkiElementsProvider(widget.subject,widget.chapter,id:widget.chapterId);
    learningMode.dataType=learningMode.scheduleCacheSystem.learning;
    timeMode=AnkiElementsProvider(widget.subject,widget.chapter,id:widget.chapterId);
    timeMode.dataType=learningMode.scheduleCacheSystem.time;



    super.initState();
  }

  refresh(){
    learningMode.cache();
    timeMode.cache();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:AppBar(
          bottom:  TabBar(
            indicatorColor:Colors.blue,
            onTap:(int index){
            //  provider.scheduleCacheSystem.box.clear();
              refresh();
            },
            tabs:const [
              Tab(
                child:const Text('بطاقات معلقة'),
              ),
              Tab(
                child:const Text('طور التعلم'),
              ),
              Tab(
                child:const Text("طور المراجعة"),
              ),
            ],
          ),
        ),
        body:TabBarView(
          children:[
            DefaultAllElements(provider),
            AnkiQuestions(provider:learningMode),
            AnkiQuestions(provider:timeMode,message:"لا توجد بطاقة تستحق المراجعة الآن",),
          ],
        ),
      ),
    );
  }
}

class DefaultAllElements extends StatelessWidget {
  final AnkiElementsProvider provider;
  DefaultAllElements(this.provider);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<AnkiQuestion>>(
      valueListenable:provider.notifier,
      child: PercentProgressIndicator(message:"جاري انشاء نظام قرائة ...",),
      builder:(BuildContext context,List<AnkiQuestion> questions,Widget _){
        if(questions==null){
          if(provider.loading.value=true)return Center(child:_,);
          return const SizedBox();
        }
        if(questions.isEmpty)return Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Center(child:Image.asset(Constans.imagePath+"badge.png",height:100,),),
            const SizedBox(height:25,),
            const Center(child:Text('يرجى الذهاب الى طور التعلم '),)
          ],
        );
        return ListView.builder(
          itemCount:questions.length,
          itemBuilder:(BuildContext context,int index){
            final AnkiQuestion question=questions[index];
            return Container(
              padding:const EdgeInsets.all(8.0),
              margin:const EdgeInsets.symmetric(horizontal:3.0,vertical:3.0),
              decoration:const BoxDecoration(
                  borderRadius:BorderRadius.all(Radius.circular(15)),
                  color:Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color:Colors.black45,
                        spreadRadius:0.1,
                        blurRadius:8.0
                    )
                  ]
              ),
              child:Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(question.question),
                  ),
                  RoyalRoundedButton(""
                      "اضافة الى طور التعلم",
                        (){
                      provider.addedToLearningMode(question.id);
                      Constans.toast("تمت الاضافة بنجاح",true);
                    },
                    circular:20,
                    buttoncolor:Colors.deepOrange,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

