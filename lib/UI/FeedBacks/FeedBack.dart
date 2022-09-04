import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/userRepo.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
class FeedBack extends StatelessWidget {
  final UserRepo repo=UserRepo();
  final ui=UiConstans.instanse;
  final royalWhite=UiConstans.whiteText;
  final String inputhint="اكتب محتوى الرسالة";
  final TextEditingController controller= TextEditingController();
  final SelectTypeOfFeedBack selectTypeOfFeedBack=SelectTypeOfFeedBack();
  final RoyalLoading loading=RoyalLoading();
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.all(25.0), child: UiConstans.logoWidget,),
              Container(width:size.width/2,decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                borderRadius:UiConstans.radius15
              ),child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('راسل الشركة الآن',style: royalWhite)),
              )),
              Padding(padding:const EdgeInsets.all(8),
                child: Container(
                  child: Padding(padding: const EdgeInsets.all(8.0), child:selectTypeOfFeedBack),),),
              ui.input(inputhint, controller,bordercolor:Colors.blue,minlines: 6),
              RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: Colors.blue,
                  child: Text('ارسال الى الشركة',style: royalWhite,),
                  onPressed:()=>postFeedBack(context))
            ],
          ),
        ),
      ),
    );
  }
   postFeedBack(BuildContext context)async{

    if(UiConstans.isnull(selectTypeOfFeedBack.value)){Constans.toast("يجب اختيار نوع الرسالة", false);return null;}
    if(UiConstans.isnull(controller.text)){Constans.toast("يجب كتابة الرسالة", false);return null;}
       Map body= selectTypeOfFeedBack.value;
    body['message']=controller.text;
    loading.loading(context);RS response= await repo.feedback(body);loading.cancel();
    if(response!=null){
     if(response.check()){Navigator.pop(context);}
    }
  }
}
// ignore: must_be_immutable
class SelectTypeOfFeedBack extends StatefulWidget {
  Map value;
  @override
  _SelectTypeOfFeedBackState createState() => _SelectTypeOfFeedBackState();
}
class _SelectTypeOfFeedBackState extends State<SelectTypeOfFeedBack> {
  final List<Map> _type=[{"id":0,"name":"شكوى"},{"id":1,"name":"مدح"},{"id":2,"name":"سؤال"}];
  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField(
        hint: Text('اختر نوع الرسالة'),
        items:_type.map((e) =>DropdownMenuItem(
            value: e,
            child: Text(e['name'].toString()))).toList(), onChanged:(e){setState((){widget.value=e;});});
  }
}


