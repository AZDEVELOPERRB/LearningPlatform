import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Chapters/chapter.dart';
import 'package:learningplatform_rb/Models/Lessons/lesson.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:learningplatform_rb/UI/SingleLesson/single_lesson_view.dart';
import 'package:learningplatform_rb/youtube.dart';
class ChapterView extends StatelessWidget {
  ChapterView(this.chapterModel);
  final ChapterModel chapterModel;
  @override
  Widget build(BuildContext context) {
  final Size size = MediaQuery
        .of(context)
        .size;
    return Material(
      color: Colors.indigoAccent,
      child: Column(
        children: [
          header(chapterModel, size, context),
          Expanded(child:
          Container(
            decoration:const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60))
            ),
            child:ListView.builder(
                itemCount:chapterModel.lessons.length,
                itemBuilder:(context,index)=>lessonWidget(chapterModel.lessons[index],size,context)),
          ))
        ],
      ),
    );
  }

  Widget lessonWidget(LessonModel lesson,Size size,BuildContext context){
    return Padding(padding:const EdgeInsets.only(top:15,right:15,left: 15),
    child: Container(
      height:size.height/5.3,
     child:Container(
       height:size.height/6,
       decoration:const BoxDecoration(
         color:Colors.blue,
         borderRadius:BorderRadius.only(topLeft:Radius.circular(40),
             topRight:Radius.circular(40),bottomLeft:Radius.circular(40)),
       ),
       child:Row(
         mainAxisAlignment:MainAxisAlignment.spaceAround,
         children:[
           player((){
             if(lesson.youtubeurl!=null)Navigator.push(context,RoyalNavigatorElasticInOut(SingleLesson(lesson)));
             else Constans.toast("لا يحتوي هذا الدرس على فيديو توضيحي",false);
           }),
           pdf(()=>showPdf(lesson.pdf.url,context,title:lesson.name)),
           Expanded(
             child:Padding(
               padding:const EdgeInsets.symmetric(horizontal:6.0),
               child: Text(lesson.name,style:TextStyle(color:Colors.white
                   ,fontWeight:FontWeight.w700,),textAlign:TextAlign.center,
                 textDirection:TextDirection.rtl,
                 ),
             )
           ),
         ],
       ),
     ),
    ),
    );
  }


  Container header(ChapterModel chapterModel, Size size, BuildContext context) {
    return Container(
      height: size.height / 3,
      width: size.width,
      child: Stack(
        children: [
          Align(alignment:const  Alignment(0.95,-0.6),
            child: InkWell(onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_forward_ios, color: Colors.white, size: 30,)),
          ),
          Align(alignment:const  Alignment(0.8, 0.2),
            child: Text(chapterModel.name, style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800),),
          ),
          if(chapterModel.youtubeurl != null)Align(
            alignment:const  Alignment(-0.8, 0.8),
            child:player(()=>_launchURL(chapterModel.youtubeurl,context,chapterModel.name))
          ),
          if(chapterModel.youtubeurl != null)Align(
            alignment:const  Alignment(0.8, 0.8),
            child: pdf(()=>showPdf(chapterModel.pdf.url,context,title:chapterModel.name)),
          )
        ],
      ),
    );
  }

  IconButton player(VoidCallback callback){
  return  IconButton(
      icon:Icon(Icons.play_circle_fill_rounded
      ,  color:Colors.white,
      ),
      iconSize: 55,
      onPressed:callback??null);

  }
  void showPdf(String url,BuildContext context,{String title}){
    if(url==null){
      Constans.toast("لا يوجد ملف بي دي اف",false);
      return;
    }
   Navigator.push(context,RoyalNavigatorElasticInOut( Scaffold(
     appBar: AppBar(
       title:  Text(title??"تطبيق منصة الصف"),
     ),
     body:PDF( autoSpacing: true,
       pageFling: true,).cachedFromUrl(
       url,
       placeholder: (progress) =>const Center(child:CircularProgressIndicator()),
       errorWidget: (error) =>const Center(child: Text("يوجد خطأ في تحميل الملف")),
     ),
   )));
  }
  InkWell pdf(VoidCallback callback){
    return  InkWell(
      onTap:callback,
      child: Icon(Icons.picture_as_pdf,
        color: Colors.white,
        size:35,
      ),
    );
  }
  _launchURL(String url,BuildContext context,String title) async {
    if(url==null){
      Constans.toast("لا يوجد فيديو",false);
      return;
    }
    Navigator.push(context, RoyalNavigatorElasticInOut(RoyalYoutube(title,url)));
  }
}


















// if (Platform.isIOS) {
//   if (await canLaunch(
//       'youtube:$url')) {
//     await launch(
//         'youtube:$url',
//         forceSafariVC:false);
//   } else {
//     if (await canLaunch('$url')){
//       await launch('$url');
//     }else{
//      Constans.toast("لا يمكن فتح هذا الفيديو",false);
//     }
//   }
// } else {
//   if (await canLaunch(url)) {
//     await launch(url);
//   }else{
//     Constans.toast("لا يمكن فتح هذا الفيديو",false);
//   }
// }