import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Comment/comment.dart';
import 'package:learningplatform_rb/UI/Comments/SingleComment/single_comment.dart';
import 'package:learningplatform_rb/providers/CommentsProvider/RepliesProvider/replies_provider.dart';
class RepliesUI extends StatefulWidget {
  RepliesUI(this.id):provider=RepliesProvider(id);
  final String id;
  final RepliesProvider provider;
  @override
  _RepliesUIState createState() => _RepliesUIState();
}

class _RepliesUIState extends State<RepliesUI> {

  @override
  void initState() {
    widget.provider.running();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Directionality(
      textDirection:TextDirection.rtl,
      child: Scaffold(
        appBar:UiConstans.appBar(size:size),
        body:Column(
          children: [
            Expanded(child:ValueListenableBuilder<List<CommentModel>>(
              valueListenable:widget.provider.commentNotifier,
              child:const RoyalEmptyData(),
              builder:(BuildContext context,List<CommentModel> replies,child){
                if(replies==null)return const Center(child:CircularProgressIndicator(),);
                return ListView.builder(
                  reverse: true,
                  itemCount:replies.length,
                  itemBuilder:(final BuildContext context,final int index){
                    return SingleReplay(replies[index],index,widget.provider);
                  },
                );
              },
            )),
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
                  Expanded(child: RoyalInputTextField("اكتب هنا",widget.provider.replayController)),
                  IconButton(icon:const Icon(Icons.send), onPressed:(){
                    widget.provider.postNewReplay(context);
                  },color:Colors.brown,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
