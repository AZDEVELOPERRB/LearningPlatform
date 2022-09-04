import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Students/Customer.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
import 'package:learningplatform_rb/providers/Teacherprovider/teacher_provider.dart';
class TeacherProfileHandler extends StatelessWidget {
  final TeacherProvider teacherProvider=TeacherProvider.instance;
  @override
  Widget build(BuildContext context) {
    return Material(
      color:Colors.white,
      child: ValueListenableBuilder<User>(valueListenable:teacherProvider.userNotifier,
          builder:(BuildContext context,User user,_){
        if(user==null)return const SizedBox();
        return TeacherProfile(teacherProvider,key:UniqueKey(),);
          }),
    );
  }
}
class TeacherProfile extends StatefulWidget {
  TeacherProfile(this.teacherProvider,{Key key}):super(key:key);
  final TeacherProvider teacherProvider;
  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}
class _TeacherProfileState extends State<TeacherProfile> {
  @override
  void initState() {
    widget.teacherProvider.initTextEditingController();
    widget.teacherProvider.refresh();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return ListView(
      children: [
         Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0,horizontal:9.0),
          child: Row(
            textDirection:TextDirection.rtl,

            children: [
              if(widget.teacherProvider.userNotifier.value?.image?.url!=null)const CircleAvatar()else CircleAvatar(backgroundImage:AssetImage('Assets/images/profile_avatar.png'),radius:45),
              const SizedBox(width:20,),
              Column(
                children: [
                  Text(widget.teacherProvider.userNotifier.value.name,style:const TextStyle(color:Colors.black54,fontSize:18,fontWeight:FontWeight.w900),textAlign:TextAlign.right,),
                  Text(widget.teacherProvider.userNotifier.value.email,style:const TextStyle(color:Colors.black54,fontSize:12,fontWeight:FontWeight.w500),),
                ],
              ),
            ],
          ),
        ),
    Align(child: RoyalRoundedButton("تغيير كلمة السر",
            (){
      RoyalDialog.publicDialog(context,
      SizedBox(
        height:size.height/2,
        width:size.width,
        child: ListView(
          children: [
            RoyalAppLogo(),
            const SizedBox(height:10,),
            RoyalInputTextField("كلمة المرور",widget.teacherProvider.passwordController,borderRadius:20,),
            RoyalInputTextField("تأكيد كلمة المرور",widget.teacherProvider.confirmPasswordController,borderRadius:20,),
            const SizedBox(height:10,),
            Align(child: RoyalRoundedButton("تعديل كلمة المرور", (){widget.teacherProvider.updatePassword(context);},circular:25,buttoncolor:Colors.blue),),

          ],
        ),
      )
      );
    },circular:20,)),
        const SizedBox(height:30,),
        RoyalInputTextField("اسم المستخدم",widget.teacherProvider.nameController,borderRadius:20,),
        RoyalInputTextField("البريد الالكتروني",widget.teacherProvider.emailController,borderRadius:20,),
        RoyalInputTextField("رقم الهاتف",widget.teacherProvider.phoneController,inputType:TextInputType.phone,borderRadius:20,),
        const SizedBox(height:15,),
        Align(child: RoyalRoundedButton("تعديل الحساب", (){widget.teacherProvider.update(context);},circular:25,buttoncolor:Colors.blue),),

      ],
    );
  }
}
