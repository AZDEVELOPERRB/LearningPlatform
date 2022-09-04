import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UiConstans{

 const UiConstans._();
 static final instanse=UiConstans._();
  static const TextStyle whiteText=TextStyle(color: Colors.white);
  static const ChosenWidgetColor=Colors.pinkAccent;
  static const BackgroundWidgetColor=Colors.black45;
  static const space25=SizedBox(height:25,);
  static const space50=SizedBox(height:50,);
  static final logoWidget=Container(height: 90,child: Image.asset('Assets/images/logo.png'),);
  static  const Royabluebackground=BoxDecoration(image: DecorationImage(image: AssetImage('Assets/images/gamebackground.jpg'),fit: BoxFit.cover));
  static final radius15=BorderRadius.circular(15);






  //colors
 static const TextStyle whiteStyle= TextStyle(color: Colors.white);
 static const TextStyle grayStyle= TextStyle(color: Colors.grey);
 static const Color lightBlue=Colors.lightBlue;
 static const Color blue=Colors.blue;
 static final  Color pink=Colors.pink[400];
 static final Color yellow=Colors.yellow[400];
 //******************************************************************************************************************



 static AppBar appBar({final Widget title,Size size}){
   return    AppBar(
     title:title??const SizedBox(),
     toolbarHeight:70,
     backgroundColor:Colors.blue.withOpacity(0.5),
     centerTitle:true,
     elevation:4,
     shape: RoundedRectangleBorder(
       borderRadius:BorderRadius.vertical(
         bottom:Radius.elliptical(size?.width??100, 56.0),
       ),
     ),
   );
 }
 //functions

 static bool isnull(var s){if(s==null||s.isEmpty){return true;}return false;}
 //*****************************************************************************************************************
  input(String hint,TextEditingController _textController,{bool password=false, Color bordercolor,int minlines}){
    return  Container(
      height:minlines!=null?minlines.toDouble()* 55/4:50,
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        obscureText: password,
        keyboardType: TextInputType.multiline,
        autofocus: false,
        minLines:minlines??1,
        maxLines: 10,
        controller: _textController,
        style: TextStyle(fontSize: 13.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          filled: true,
          fillColor: Colors.white70,
          contentPadding: const EdgeInsets.only(
              left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color:bordercolor??Colors.green),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: bordercolor??Colors.blue),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
class RoyalBlankContainer extends StatelessWidget {
  List<Widget> children;
  RoyalBlankContainer(this.children,{this.circular});
   final double circular;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical:6.0,horizontal:circular==null?1.0:4.0),
      child: Container(
        width:double.maxFinite,
        decoration: BoxDecoration(
            color:Colors.white,
            borderRadius:BorderRadius.all(Radius.circular(circular??0)),
            boxShadow:[
              BoxShadow(
                  color:Colors.black38,
                  blurRadius:8.0,
                  spreadRadius:0.1
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:25,horizontal:10.0),
          child: Row(
            textDirection:TextDirection.rtl,
            mainAxisAlignment:children.length==0?MainAxisAlignment.start:MainAxisAlignment.spaceBetween,
            children:children,
          ),
        ),
      ),
    );
  }
}

class RoyalInputTextField extends StatelessWidget {
  RoyalInputTextField(this.hint, this.textEditingController,{this.password,this.inputType,this.maxLines,this.borderRadius});
  final String hint;
  final TextEditingController textEditingController;
  final bool password;
  final TextInputType inputType;
  final int maxLines;
  final double borderRadius;
  @override
  Padding build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Directionality(
        textDirection:TextDirection.rtl,
        child: TextField(
        obscureText:password??false,
          maxLines:maxLines??1,
          autofocus: false,
          controller: textEditingController,
          textAlign:TextAlign.right,
          keyboardType:inputType??TextInputType.text,
          style: TextStyle(fontSize: 13.0, color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText:"  "+hint ,
            labelStyle:const TextStyle(color:Colors.blue,fontSize:14,fontWeight:FontWeight.bold),
            alignLabelWithHint: true,
            filled: true,
            fillColor: Colors.white70,
            contentPadding: const EdgeInsets.only(
                left: 14.0, bottom: 6.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(borderRadius??10.0),
            ),
          ),
        ),
      ),
    );
  }

}

class RoyalAppLogo extends StatelessWidget {
  RoyalAppLogo({this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Image.asset("Assets/images/logo.png",height:height??100,);
  }
}

class RoyalRoundedButton extends StatelessWidget {
  RoyalRoundedButton(this.hint,this.onClick,{this.buttoncolor,this.circular,this.child});
  final VoidCallback onClick;
  final String hint;
  final Color buttoncolor;
  final double circular;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return  RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circular??5),
        ),
        color:buttoncolor??Colors.black54,
        child:child??Text(hint,style: UiConstans.whiteStyle,textAlign:TextAlign.center,),
        onPressed:onClick);
  }
}


class RoyalLoadingLinear extends StatelessWidget {
  const RoyalLoadingLinear({this.alignment});
  final AlignmentGeometry alignment;
  @override
  Widget build(BuildContext context) {
    return  Align(
        alignment: alignment??Alignment(0,0.9),
        child:const  LinearProgressIndicator());
  }

}

// ignore: must_be_immutable
class RoyalImagePicker extends StatefulWidget {
  RoyalImagePicker({this.hint});

  File image;
  final String hint;


  @override
  _RoyalImagePickerState createState() => _RoyalImagePickerState();
}

class _RoyalImagePickerState extends State<RoyalImagePicker> {
  final ImagePicker picker=ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RoyalRoundedButton(widget.hint??"اختر صورة", () {
        selectImage();
      },buttoncolor:Colors.orange,),
      const SizedBox(height: 20,),
      widget.image!=null?Image.file(widget.image):const SizedBox(),

    ],);
  }
  selectImage()async{
    final PickedFile file=await picker.getImage(source:ImageSource.gallery
        ,maxHeight:1240,maxWidth:1240);
    final File imageFile=File(file.path);
    setState(() {
      widget.image=imageFile;
    });
  }
}

class RoyalExpandedContainer extends StatelessWidget {
 const RoyalExpandedContainer({this.child,this.height,this.onTap});
  final Widget child;
  final double height;
  final GestureTapCallback onTap;
  @override
  Expanded build(BuildContext context) {
    return  Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height:height??100,
          margin:const EdgeInsets.all(5.0),
          padding:const EdgeInsets.all(5.0),
          decoration:const BoxDecoration(
              color:Colors.white,
              borderRadius:BorderRadius.all(Radius.circular(15)),
              boxShadow:[
                BoxShadow(
                    color:Colors.black26,
                    blurRadius: 9.0,
                    spreadRadius: 1.0
                )
              ]
          ),
          child:child??const SizedBox(),
        ),
      ),
    );
  }
}


class RoyalEmptyData extends StatelessWidget {
  const RoyalEmptyData({this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          Image.asset("Assets/images/lazy.gif",height:60,),
          const SizedBox(height:15,),
          if(message==null)const Text('لا توجد بيانات',style: TextStyle(color:Colors.black54,fontSize:12),textAlign:TextAlign.center,),
          if(message!=null)Text(message,style: TextStyle(color:Colors.black54,fontSize:12),textAlign:TextAlign.center,),
        ],
      ),
    );
  }
}

class RoyalCacheImage extends StatelessWidget {
  RoyalCacheImage(this.url,{this.width,this.fit,this.height,this.takeRequiredSpace});
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final bool takeRequiredSpace;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key:UniqueKey(),
      imageUrl:url,
      height:height??(takeRequiredSpace==null?150:null),
      width:width??100,
    fit:fit??BoxFit.fitWidth,
    progressIndicatorBuilder:(context,s,d){
      return const Align(
        child:SizedBox(
          height:20,
          width:30,
          child: LinearProgressIndicator(),
        ),
      );
    },
    );
  }
}
class RoyalCacheProfileImage extends StatelessWidget {
  RoyalCacheProfileImage(this.url,{this.width,this.fit,this.height});
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    if(url==null||url=="")return Image.asset(
        "Assets/images/profile_avatar.png",height:height??55);
    return CachedNetworkImage(
      key:UniqueKey(),
      imageUrl:url,
      height: height??150,
      width:width??height??150,
      fit:fit??BoxFit.fitWidth,
      imageBuilder:(BuildContext context,imageProvider){
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image:DecorationImage(
            image:imageProvider,
            fit:fit??BoxFit.fill,
          )
        ),
      );
      },
      errorWidget:(BuildContext context,String url,dynamic error){
        return Image.asset(
            "Assets/images/profile_avatar.png",height:height??55);
      },
      progressIndicatorBuilder:(context,s,d){
        return const Align(
          child:SizedBox(
            height:20,
            width:30,
            child: LinearProgressIndicator(),
          ),
        );
      },
    );
  }
}

class PercentProgressIndicator extends StatefulWidget {
  final String message;
  const PercentProgressIndicator({this.message=''});


  @override
  _PercentProgressIndicatorState createState() => _PercentProgressIndicatorState();
}

class _PercentProgressIndicatorState extends State<PercentProgressIndicator> {
  double value= 0;
  Timer _timer;


  @override
  void initState() {
    startProgress();
    super.initState();
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }



  startProgress(){
    _timer??=Timer.periodic(const Duration(milliseconds:100), (timer){
      setState(() {
        if(value>=100)value=0;
        else value+=0.1;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize:MainAxisSize.min,
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Text(widget.message,style:const TextStyle(color:Colors.blueGrey),),
        space,
        Text(' % ${value.toStringAsFixed(1)}'),
        space,
        Directionality(
            textDirection:TextDirection.ltr,
            child: LinearProgressIndicator(value:value/100,
            valueColor:AlwaysStoppedAnimation<Color>(Colors.green),))
      ],
    );
  }
  final SizedBox space=const SizedBox(height:10,);
}

class AppDirection extends StatelessWidget {
  final Widget child;
  AppDirection({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection:TextDirection.rtl,
        child:child);
  }
}
