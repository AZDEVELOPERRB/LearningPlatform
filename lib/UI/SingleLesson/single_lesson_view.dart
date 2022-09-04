import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Handler/LessonHandler/lesson_handler.dart';
import 'package:learningplatform_rb/Models/Lessons/lesson.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/Comments/Comment/comment.dart';
import 'package:learningplatform_rb/UI/ExaminateNow/examinate_now.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SingleLesson extends StatefulWidget {
  SingleLesson(this.lesson):handler=LessonHandler(lesson);
  final LessonModel lesson;
  final LessonHandler handler;
  @override
  _SingleLessonState createState() => _SingleLessonState();
}
class _SingleLessonState extends State<SingleLesson> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    if(widget.lesson.youtubeurl!=null){
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.lesson.youtubeurl),
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body:ListView(children:[
       if(widget.lesson.youtubeurl!=null) YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: false,
        )
        else Center(child: const Text('لا يمتلك هذا الدرس فيديو ')),
        const SizedBox(height:10,),
        const  Center(child:  Text('هل فهمت الدرس من خلال المحاضرة ؟',style:TextStyle(color:Colors.black54,fontWeight:FontWeight.w700),textAlign:TextAlign.center,)),
        const SizedBox(height:5,),
        Row(
          mainAxisAlignment:MainAxisAlignment.center,
          mainAxisSize:MainAxisSize.min,
          children: [
            RoyalLikeIcons(widget.handler,isLike:false,),
            const SizedBox(width:25,),
           RoyalLikeIcons(widget.handler,isLike:true,)
          ],
        ),
        const SizedBox(height:10,),
        const  Center(child:  Text('اضف تقييمك',style:TextStyle(color:Colors.brown,fontWeight:FontWeight.w700),textAlign:TextAlign.center,)),
        Center(
          child:ValueListenableBuilder<double>(
            valueListenable:widget.lesson.rating,
            builder:(_,double rating,child){
              return  RatingBar(
                textDirection:TextDirection.rtl,
                initialRating:rating,
                itemSize:30,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding:const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                ),
                onRatingUpdate: (rating) {
                  widget.lesson.rating.value=rating;
                  widget.handler.postRating(rating);
                },
              );
            },
          )
        ),
        const SizedBox(height:20,),

        Row(
          children: [
            RoyalExpandedContainer(
              onTap:(){
                _controller.pause();
                Navigator.push(context,RoyalNavigatorElasticInOut(Comments(widget.handler)));
              },
              child:Column(
                children: [
                  Expanded(child: Image.asset('Assets/images/people.gif'),),
                  const  Text('اسئلة واجوبة',style:TextStyle(color:Colors.blue,fontWeight:FontWeight.w500),)
                ],
              ),
            ),
            RoyalExpandedContainer(
              onTap:(){
                if(widget.lesson.exam==null){
                  Constans.toast("لا يوجد امتحان",false);
                  return;
                }
                _controller.pause();
                Navigator.push(context, RoyalNavigatorElasticInOut(ExaminateNow(widget.lesson.exam)));
              },
              child:Column(
                children: [
                  Expanded(child: Image.asset('Assets/images/pencil.gif'),),
                  const Text('ابدأ الاختبار',style:TextStyle(color:Colors.blue,fontWeight:FontWeight.w500),)
                ],
              ),
            ),

          RoyalExpandedContainer(
                      onTap:(){
                     _controller.pause();
                Navigator.push(context,RoyalNavigatorElasticInOut(Comments(widget.handler,isQuestion:false,)));
               },
            child:Column(
              children: [
               Expanded(child: Image.asset('Assets/images/comment.gif'),),
                const Text('التعليقات',style:TextStyle(color:Colors.blue,fontWeight:FontWeight.w500),)
              ],
            ),
          ),

        ],)
      ],),
    );
  }

}
class RoyalLikeIcons extends StatelessWidget {
  RoyalLikeIcons(this._handler,{this.isLike});
  final bool  isLike;
  final LessonHandler _handler;
  @override
  Container build(BuildContext context) {
    return
      Container(
          padding:const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              shape:BoxShape.circle,
              color:Colors.grey.shade200
          ),
          child:InkWell(
            onTap:(){
              if(isLike){
                if(_handler.lessonModel.likeProperty.value!=true){
                  _handler.lessonModel.likeProperty.value=true;
                  _handler.postLike(true);
                }
              }
              else{
                if(_handler.lessonModel.likeProperty.value!=false){
                  _handler.lessonModel.likeProperty.value=false;
                  _handler.postLike(false);
                }
              }
            },
            child: ValueListenableBuilder<bool>(
              valueListenable:_handler.lessonModel.likeProperty,
              builder:(BuildContext context,bool like,child){
               return Icon(isLike?FlutterIcons.thumb_up_outline_mco:FlutterIcons.thumb_down_outline_mco,size:30,
                 color:like==null?Colors.black54:isLike&&like?Colors.blue:!isLike&&!like?Colors.blue:Colors.black54,);
              },
            ),
          )
      );
  }
}
