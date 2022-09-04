import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Students/CustomerHolder.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
import 'package:learningplatform_rb/providers/userProvider/userProvider.dart';
class ProfileInputs{
ProfileInputs(this.provider);
final  UserProvider provider;
  CustomerHolder customerHolder=CustomerHolder();
final Constans constans=Constans();

  TextEditingController namecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController confirmpasswordcontroller=TextEditingController();

  String name="اسم الطالب";
  String email="ايميل الطالب";
  String phone="رقم الهاتف";
Future<RS>nameFunction()async{
    if(namecontroller.text.isEmpty){constans.royaltoast("يجب االتاكد من الحقل", false);return null;}
    await initializeholder();
    customerHolder.name=namecontroller.text;
  final Map toServer=customerHolder.toMap();
    clearcontrollers();
    return await provider.updateUser(toServer);
  }
Future<RS>phoneFunction()async{
  if(phonecontroller.text.isEmpty){constans.royaltoast("يجب االتاكد من الحقل", false);return null;}
  await initializeholder();
  customerHolder.phone=phonecontroller.text;
  final Map toServer=customerHolder.toMap();
  clearcontrollers();
  return await provider.updateUser(toServer);
}
Future<RS>emailFunction()async{
  if(emailcontroller.text.isEmpty){constans.royaltoast("يجب االتاكد من الحقل", false);return null;}
  await initializeholder();
  customerHolder.email=emailcontroller.text;
  final Map toServer=customerHolder.toMap();
  clearcontrollers();
 return await provider.updateUser(toServer);
}
Future<RS>countrycity(String country,String city)async{
  if(country.isEmpty||city.isEmpty){constans.royaltoast("يجب االتاكد من الحقول", false);return null;}
  await initializeholder();
  customerHolder.Countryid=country;
  customerHolder.city=city;
  final Map toServer=customerHolder.toMap();
  clearcontrollers();
  return await provider.updateUser(toServer);
}
Future<RS>passwordfunction()async{
if(constans.passwordconfirm(passwordcontroller.text, confirmpasswordcontroller.text)){
  await initializeholder();
  customerHolder.password=passwordcontroller.text;
 final Map toServer=customerHolder.toMap();
  clearcontrollers();
  return await provider.updateUser(toServer);
}
clearcontrollers();
return null;
}
clearcontrollers(){
  namecontroller.clear();
  emailcontroller.clear();
  phonecontroller.clear();
  passwordcontroller.clear();
  confirmpasswordcontroller.clear();
}
initializeholder()async{
  customerHolder=CustomerHolder();
  customerHolder.fcm=await fcm();
}
Future<String> fcm()async{
 return await Constans.fcm();
}




passwordui(BuildContext context,Widget input,Widget input2){
  RoyalDialog.publicDialog(context,
      Container(
        height:300,
        width: 140,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height:60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Assets/images/logo.png'),
                    )
                ),
              ),
              SizedBox(height: 15,),
              input,
              SizedBox(height: 15,),
              input2,

              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: Colors.blue,
                      child: Text('تحديث',style: UiConstans.whiteText,),
                      onPressed:()async{Navigator.pop(context);passwordfunction();}
                  ),
                  RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: Colors.red,
                      child: Text('الغاء',style: UiConstans.whiteText,),
                      onPressed:(){Navigator.pop(context);}
                  ),
                ],
              )
            ],
          ),
        ),
      )
  );
}
}