import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Profile/Widgets/Carditem.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Profile/Widgets/InputHelpers/ProfileInputs.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Profile/Widgets/StackContainer.dart';
import 'package:learningplatform_rb/UI/GPS/CountriesUI.dart';
import 'package:learningplatform_rb/UI/GradesSelect/GradesSelect.dart';
import 'package:learningplatform_rb/providers/userProvider/userProvider.dart';
import 'package:provider/provider.dart';
class Profile extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<Profile> {
final CountriesUI _countriesUI=CountriesUI();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (BuildContext context,UserProvider userprovider,_){
        if(userprovider!=null&&userprovider.user!=null) {
          final ProfileInputs  _inputs=ProfileInputs(userprovider);
          return  Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  StackContainer(userprovider),
                  passwordWidget(_inputs),
                  Container(
                    padding:const EdgeInsets.all(8.0),
                    margin:const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color:Colors.blue.shade50,
                        borderRadius:const BorderRadius.all(Radius.circular(30)),
                      boxShadow:const[
                        BoxShadow(
                          color:Colors.black12,
                          spreadRadius:0.5,
                          blurRadius:9.0
                        )
                      ]
                    ),
                    child:Directionality(
                      textDirection:TextDirection.rtl,
                      child: Column(
                        children: [
                          Text('محفظتك'),
                          Row(
                            mainAxisSize:MainAxisSize.min,
                            children:[

                              Image.asset(Constans.imagePath+"wallet.png"),

                              const SizedBox(width:10,),

                              Text(userprovider.user.getWallet(),style:const TextStyle(color:Colors.green,fontWeight:FontWeight.bold),)

                            ],
                          ),
                        ],
                      ),
                    ),

                  ),
                  ListView(
                    physics:const NeverScrollableScrollPhysics(),
                    shrinkWrap:true,
                    children: [
                      CardItem(Icons.account_box_outlined,Colors.blue,userprovider.user.name,"اسم الطالب الجديد",input(_inputs.name, _inputs.namecontroller),_inputs.nameFunction),
                      CardItem(Icons.school,Colors.blue,userprovider.user.className??"","الصف",Container(),(){},height:800,sfunction: (){Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SelectGrades(userProvider:userprovider,)));},),
                      CardItem(Icons.email_outlined,Colors.pinkAccent,userprovider.user.email,"البريد الاكتروني",input("البريد الاكتروني", _inputs.emailcontroller),_inputs.emailFunction),
                      CardItem(Icons.phone,Colors.green,userprovider.user.phone,"رقم الهاتف",input("رقم الهاتف ", _inputs.phonecontroller),_inputs.phoneFunction),
                      CardItem(Icons.gradient_rounded,Colors.black,userprovider.user.country.name,"البلد",_countriesUI,(){_inputs.countrycity(_countriesUI.cid,_countriesUI.subid);},height: 300,),
                      CardItem(Icons.gps_fixed,Colors.red,userprovider.user.city.name,"المدينة",_countriesUI,(){_inputs.countrycity(_countriesUI.cid,_countriesUI.subid);},height: 300,),
                    ],
                  )
                ],
              ),
            ),
          );
        } else
          return Container();
      },
    );}

  Widget passwordWidget(ProfileInputs _inputs){
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.black45,
        child: Padding(
          padding: const EdgeInsets.only(left:15.0),
          child: Text('تغيير كلمة السر',style:const TextStyle(color: Colors.white),),
        ),
        onPressed:(){
          _inputs.passwordui(context,input("اكتب كلمة السر الجديدة",_inputs.passwordcontroller,password: true),input("تأكيد كلمة السر",_inputs.confirmpasswordcontroller,password: true));
        });
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
}