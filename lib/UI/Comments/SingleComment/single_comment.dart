import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Comment/comment.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/Comments/Replies/replies_ui.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
import 'package:learningplatform_rb/database/base_local.dart';
import 'package:learningplatform_rb/providers/CommentsProvider/RepliesProvider/replies_provider.dart';
import 'package:learningplatform_rb/providers/CommentsProvider/comment_provider.dart';
class SingleComment extends StatefulWidget {
  SingleComment(this.commentModel,{this.provider,@required this.index,this.question=true});
  final CommentModel commentModel;
  final CommentProvider provider;
  final int index;
  final bool question;
  @override
  _SingleCommentState createState() => _SingleCommentState();
}

class _SingleCommentState extends State<SingleComment> {


  void lookAtComment(){
    widget.provider.lookAtComment(widget.commentModel.id);
  }
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap:(){
        lookAtComment();
      },

      child: Container(
        margin:const EdgeInsets.all(8.0),
        padding:const EdgeInsets.all(9.0),
        decoration:const BoxDecoration(
            color:Colors.white,
            borderRadius:BorderRadius.all(Radius.circular(15)),
            boxShadow:[
              BoxShadow(
                  color:Colors.black26,
                  blurRadius:9.0,
                  spreadRadius:1.0
              )
            ]
        ),
        child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Row(children:[
                  RoyalCacheProfileImage(
                    widget.commentModel.creator?.image?.url??null,
                    height:55,
                    width:55,
                  ),
                  /// here The Profile Image
                  // Image.asset("Assets/images/profile_avatar.png",height:55,),
                  const SizedBox(width:10,),
                  Column(
                    children: [
                       Text(widget.commentModel.creator.name??"",textAlign:TextAlign.right,style:TextStyle(color:Colors.brown,fontSize:16,fontWeight:FontWeight.w400),),
                       Text(widget.commentModel.createdAt??"",textAlign:TextAlign.right,style:TextStyle(color:Colors.black54,fontSize:11),)
                    ],
                  )
                ],),
               if(BaseLocal.userId()==widget.commentModel.creator.id)PopupMenuButton(
                  onSelected:(e)=>delete(widget.index),
                  itemBuilder: (BuildContext context) {
                    return [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceAround,
                        children:const[
                           Text('حذف'),
                          Icon(Icons.delete,color:Colors.deepOrange,)
                        ],
                      )
                    ].map((e) {
                      return  PopupMenuItem(child:e,
                      value:"delete",
                      );
                    }

                    ).toList();
                  },
                ),

                // IconButton(icon:const Icon(FlutterIcons.list_mdi),
                //   onPressed:(){
                //
                //   },
                // )
              ],
            ),
            const SizedBox(height:20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Text(widget.commentModel.comment,textAlign:TextAlign.right,),
            ),
            const SizedBox(height:20,),
            widget.question?Row(
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              children: [
                Like(widget.commentModel,widget.provider),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,RoyalNavigatorElasticInOut(RepliesUI(widget.commentModel.id)));
                  },
                  child: Row(children: [
                    Icon(FlutterIcons.comment_eye_outline_mco,color:Colors.blue,),
                    const SizedBox(width:5,),
                    const Text('اجابة'),
                  ],),
                ),
                Row(children: [
                  Icon(FlutterIcons.eye_outline_mco,color:Colors.black54,),
                  const SizedBox(width:5,),
                   Text(widget.commentModel.views.toString(),style:const TextStyle(color:Colors.black54),),
                ],),
              ],
            ): GestureDetector(
              onTap: (){
                lookAtComment();
                Navigator.push(context,RoyalNavigatorElasticInOut(RepliesUI(widget.commentModel.id)));
              },
              child: Row(
                children: [
                  const SizedBox(width: 15,),
                  Icon(FlutterIcons.comment_eye_outline_mco,color:Colors.blue,),
                  const SizedBox(width:5,),
                  const Text('رد'),
                ],),
            )
          ],
        ),
      ),
    );
  }

  delete(final int index){
    RoyalDialog.showMessage(context,message:"هل تريد فعلاً حذف هذا ${widget.question?"السؤال":"التعليق"} ؟",
    onAgree:(){
      Navigator.pop(context);
      widget.provider.deleteComment(index,context);

    }
    );
  }
}
class Like extends StatelessWidget {
  Like(this.commentModel,this.provider);
  final CommentProvider provider;
  final CommentModel commentModel;
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap:(){
        if(commentModel.liked.value==true)commentModel.likes--;
        else commentModel.likes++;
        commentModel.liked.value=!commentModel.liked.value;
        provider.commentLike(commentModel.liked.value,commentModel.id);
      },
      child: ValueListenableBuilder<bool>(valueListenable:commentModel.liked,
          child: const Icon(FlutterIcons.heart_outline_mco,color:Colors.red,),
          builder:(BuildContext context,bool value,child){
           return Row(children: [
             !value?child:const Icon(FlutterIcons.heart_mco,color:Colors.red,),
              const SizedBox(width:5,),
              Text(commentModel.likes.toString())
            ],);
          }),


    );
  }

}
class SingleReplay extends StatefulWidget {
  SingleReplay(this.commentModel,this.index,this.provider);
  final CommentModel commentModel;
  final int index;
  final RepliesProvider provider;
  @override
  _SingleReplayState createState() => _SingleReplayState();
}

class _SingleReplayState extends State<SingleReplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(8.0),
      padding:const EdgeInsets.all(9.0),
      decoration:const BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.all(Radius.circular(15)),
          boxShadow:[
            BoxShadow(
                color:Colors.black26,
                blurRadius:9.0,
                spreadRadius:1.0
            )
          ]
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Row(children:[

                /// here The Profile Image
                RoyalCacheProfileImage(
                  widget.commentModel.creator?.image?.url??null,
                  height:55,
                  width:55,
                ),
                const SizedBox(width:10,),
                Column(
                  children: [
                    Text(widget.commentModel.creator.name??"",textAlign:TextAlign.right,style:TextStyle(color:Colors.brown,fontSize:16,fontWeight:FontWeight.w400),),
                    Text(widget.commentModel.createdAt??"",textAlign:TextAlign.right,style:TextStyle(color:Colors.black54,fontSize:11),)
                  ],
                )
              ],),
              PopupMenuButton(
                onSelected:(e)=>delete(widget.index),
                itemBuilder: (BuildContext context) {
                  return [
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children:const[
                        Text('حذف'),
                        Icon(Icons.delete,color:Colors.deepOrange,)
                      ],
                    )
                  ].map((e) {
                    return  PopupMenuItem(child:e,
                      value:"delete",
                    );
                  }

                  ).toList();
                },
              ),

              // IconButton(icon:const Icon(FlutterIcons.list_mdi),
              //   onPressed:(){
              //
              //   },
              // )
            ],
          ),
          const SizedBox(height:20,),
          Text(widget.commentModel.comment,textAlign:TextAlign.right,),
          const SizedBox(height:20,),
          GestureDetector(
            onTap: (){
              Navigator.push(context,RoyalNavigatorElasticInOut(RepliesUI(widget.commentModel.id)));
            },
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              children: [

              ],
            ),
          )
        ],
      ),
    );
  }
  delete(final int index){
    RoyalDialog.showMessage(context,message:"هل تريد فعلاً الحذف ؟",
        onAgree:(){
          Navigator.pop(context);
          widget.provider.deleteReplay(index,context);
        }
    );
  }
}
