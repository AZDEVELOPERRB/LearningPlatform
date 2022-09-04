import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
import 'package:learningplatform_rb/UI/Auth/auth_screens/BackgroundPainter.dart';
import 'package:learningplatform_rb/UI/GPS/CountriesUI.dart';
import 'package:learningplatform_rb/UI/Teacher/Auth/teacher_auth_screen.dart';
import 'package:learningplatform_rb/providers/userProvider/userProvider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>with SingleTickerProviderStateMixin {
final RoyalLoading royalLoading=RoyalLoading();
  CountriesUI _countriesUI=CountriesUI();
  AnimationController _animationController;
TextEditingController _nameLogin=new TextEditingController();
TextEditingController _password=new TextEditingController();
TextEditingController _nameRegisterController=new TextEditingController();
TextEditingController _paswordRegisterController=new TextEditingController();
TextEditingController _confirmpaswordRegisterController=new TextEditingController();
TextEditingController _emailRegisterController=new TextEditingController();
TextEditingController _phoneRegisterController=new TextEditingController();

  @override
  void initState() {
   _animationController=AnimationController(vsync: this,duration: Duration(seconds: 2));
    super.initState();
  }




  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isLogin=true;
  bool loading=false;
  bool isTeacher=false;
  
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(
                  animation: _animationController.view
                ),
              )
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: Container(
                    width: 120,
                    height: 100,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      // color: Colors.white70,
                      // image: DecorationImage(
                      //   image: AssetImage("Assets/images/logo_le.png"),
                      //   fit: BoxFit.fill
                      // )

                    ),
                    child: Image.asset("Assets/images/logo.png"),
                  ),
                ),
              ),
            ),
      SingleChildScrollView(
        child: Container(
          padding: isLogin?EdgeInsets.only(top: 140):EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height:55),
              const SizedBox(height:55),
              const SizedBox(height:55),

              isLogin?Container():input('اسم المستخدم',_nameRegisterController),
              isLogin?Container():input('كلمة السر',_paswordRegisterController,password: true),
              isLogin?Container():input('تأكيد كلمة السر',_confirmpaswordRegisterController,password: true),
              isLogin?Container():input('البريد الالكتروني',_emailRegisterController),
              isLogin?Container():input('رقم الهاتف',_phoneRegisterController),
              isLogin?Container():_countriesUI,
              !isLogin?Container():input('البريد الالكتروني',_nameLogin),
              !isLogin?Container():input('كلمة السر',_password,password: true),
              loading?Padding(
               padding: const EdgeInsets.all(8.0),
               child: CircularProgressIndicator(
                 valueColor:AlwaysStoppedAnimation<Color>(Colors.black),
               ),
             ):Padding(
               padding: const EdgeInsets.only(bottom:14.0,left: 18,right: 18),
               child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: Colors.blue,
                    child: Text(isLogin?'تسجيل دخول':"انشاء حساب",style: UiConstans.whiteStyle,),
                    onPressed: ()async{
                   await   royalLoading.loading(context);
                      if(isLogin){ await _login();} else{await _register();}
                    await  royalLoading.cancel();
                     }),
             ),
              RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  color: Colors.black54,
                  child: Text("هل انت مدرس مادة؟",style: UiConstans.whiteStyle,textAlign:TextAlign.center,),
                  onPressed: ()async{
                  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
                    builder:(context)=>TeacherAuthScreen()
                  ), (route) => false);
                  }),



            ],

          ),
        ),
      )
           ,

            loading?Container():Positioned.fill(
              top: 50,
              right: 10,
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: !isLogin?Colors.green:Colors.blueGrey,
                      onPressed: ()async{



                        setState(() {
                          isLogin=false;
                        });
                       await Future.delayed(Duration(milliseconds: 240)).then((value) {
                         _animationController.forward();
                       });



                      },
                      child: Text('انشاء حساب',style: UiConstans.whiteStyle),
                    ),
                    SizedBox(width: 5,),
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: isLogin?Colors.green:Colors.blueGrey,
                      onPressed: ()async{

                        setState(() {
                          isLogin=true;
                        });

                        await Future.delayed(Duration(milliseconds: 240)).then((value) {
                          _animationController.reverse();
                        });

                      },
                      child: Text("تسجيل دخول", style:UiConstans.whiteStyle),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      )
    );
  }


  Widget input(String hint,TextEditingController _textController,{bool password=false}){
    return  Container(
      height: 55,
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        obscureText: password,
        autofocus: false,
        controller: _textController,
        style: TextStyle(fontSize: 13.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          filled: true,
          fillColor: Colors.white70,
          contentPadding: const EdgeInsets.only(
              left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
  _login()async{
    List<TextEditingController> _allc=[_nameLogin,_password];
    for(var val in _allc){
      if(!_validate(val)){
        Constans.toast("يجب ان تقوم باكمال جميع الحقول", false);
        return;
      }
    }
   final dynamic d= await UserProvider().login(
       Constans.royalDebug?"test1@gmail.com":_nameLogin.text,
       Constans.royalDebug?"12345678": _password.text,
       isTeacher:isTeacher);
    return d;
  }
  _register()async{

    if(_countriesUI.subid==''){Constans.toast("يجب ان تحدد بلدك والمحافظة", false);return null;}
    List<TextEditingController> _allc=[_nameRegisterController,_emailRegisterController,_paswordRegisterController,_confirmpaswordRegisterController,
    _phoneRegisterController
    ];
    if(_paswordRegisterController.text!=_confirmpaswordRegisterController.text){Constans.toast("كلمات السر يجب ان تتطابق", false);return;}
    if(_paswordRegisterController.text.length<8){ Constans.toast("يجب ان تكون كلمة السر اكثر من 8", false); return null;}
    for(TextEditingController cont in _allc){
      if(!_validate(cont)){
        Constans.toast("يجب ان تقوم باكمال جميع الحقول", false);
        return;
      }
    }
  final  Map body={
      "name":_nameRegisterController.text,
      "email":_emailRegisterController.text,
      "phone":_phoneRegisterController.text,
      "password":_paswordRegisterController.text,
      "confirmation_password":_paswordRegisterController.text,
      "Country":_countriesUI.cid,
      "state":_countriesUI.subid,

    };
    final response=await  UserProvider().register(body);
    return response;
  }
  _validate(TextEditingController _co){
    if(_co==null){
      return false; }
    if(_co.text==""){return false;}

    return true;
  }
}
