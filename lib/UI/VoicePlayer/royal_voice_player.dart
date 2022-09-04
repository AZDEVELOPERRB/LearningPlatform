import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RoyalVoicePlayer extends StatefulWidget {
  final String url;
  final String message;
  final Color backGroundColor;
  RoyalVoicePlayer({@required this.url,this.message,this.backGroundColor,Key key}):super(key: key);
  @override
  _RoyalVoicePlayerState createState() => _RoyalVoicePlayerState();
}
class _RoyalVoicePlayerState extends State<RoyalVoicePlayer> {

  bool play=null;
  final AudioPlayer audioPlayer=AudioPlayer();
  @override
  void initState() {
    start();
    super.initState();
  }
  start()async{
   await audioPlayer.setUrl(widget.url);
   setState(() {
     play=false;
   });
  }
  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(play==null)return const SizedBox(
      height:20,
      width: 20,
      child:Center(child:CircularProgressIndicator(),),
    );
    return InkWell(
      onTap:(){
        if(play){
          audioPlayer.pause();
          setState(() {
            play=false;
          });
        }else{
          audioPlayer.play();
          setState(() {
           play=true;
          });
        }
      },
      borderRadius:borderRadius,
      child: Container(
        padding:const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color:widget.backGroundColor??Colors.blue.shade100,
          borderRadius:borderRadius
        ),
        child:Row(
          mainAxisAlignment:MainAxisAlignment.spaceAround,
          mainAxisSize:MainAxisSize.min,
          children:[
            Text(
                play==true?"ايقاف":"تشغيل"
            ),
          const SizedBox(width:10,),
          Icon(play?Icons.pause:Icons.play_circle_fill_rounded,size:30,),

        ],),
      ),
    );
  }
  final BorderRadius borderRadius=BorderRadius.circular(20);
}
