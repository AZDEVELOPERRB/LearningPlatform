import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Handler/LessonHandler/CommentHandler/comment_handler.dart';
import 'package:learningplatform_rb/Handler/LessonHandler/lesson_handler.dart';
import 'package:learningplatform_rb/Models/Comment/comment.dart';
import 'package:learningplatform_rb/UI/Comments/SingleComment/single_comment.dart';
class Comments extends StatefulWidget {
  Comments(this.handler,{this.isQuestion=true}):commentHandler=CommentHandler(handler.lessonModel,newUrl:isQuestion==true?null:Api.allCommentsComments);
  final LessonHandler handler;
  final bool isQuestion;
  final CommentHandler commentHandler;
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  void initState() {
    widget.commentHandler.provider.running();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
   return Scaffold(
     appBar:UiConstans.appBar(size:size),
     body:Directionality(
       textDirection:TextDirection.rtl,
       child: Column(
         children:[
           Expanded(
             child:Stack(
               children: [
                 ValueListenableBuilder<List<CommentModel>>(
                   valueListenable:widget.commentHandler.provider.commentNotifier,
                   builder:(BuildContext context,List<CommentModel> comments,child){
                     if(comments==null)return const Center(child: CircularProgressIndicator(),);
                     if(comments.isEmpty)return const RoyalEmptyData();
                     return ListView.builder(
                       reverse:true,
                       itemCount:comments.length,
                       itemBuilder:(BuildContext context,final int index){
                         return SingleComment(comments[index],provider:widget.commentHandler.provider,index:index,question:widget.isQuestion,);
                       },
                     );
                   },
                 ),
                 ValueListenableBuilder<bool>(valueListenable:widget.commentHandler.provider.loading,
                     child:Align(alignment:Alignment.bottomCenter,child: LinearProgressIndicator()),
                     builder:(BuildContext context,bool value,child){
                       if(value==false)return Container();
                       return child;
                     })
               ],
             ),
           ),
           Container(
             height:size.height/9,
            width:size.width,
            decoration:const BoxDecoration(
              color:Colors.white,
              borderRadius:BorderRadius.vertical(top:Radius.circular(10)),
              boxShadow:[
                BoxShadow(color:Colors.black26, blurRadius:9.0, spreadRadius:1.0)
              ]
            ),
             child:Row(
               children:[
                 Expanded(child: RoyalInputTextField("اكتب هنا",widget.commentHandler.commentController)),
                 IconButton(icon:const Icon(Icons.send), onPressed:(){
                   widget.commentHandler.postNewComment(context,isQuestion:widget.isQuestion==true?null:false);
                 },color:Colors.brown,),
               ],
             ),
           )
         ],
       ),
     )
   );
  }
}
