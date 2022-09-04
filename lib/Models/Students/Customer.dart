import 'package:learningplatform_rb/Models/GPS/Countries.dart';
import 'package:learningplatform_rb/Models/GPS/city.dart';
import 'package:learningplatform_rb/Models/Image/image.dart';
import 'package:learningplatform_rb/RoyalServices/PriceFormat/royal_price_format.dart';

class User{
  String id,name,email,phone,createdat,updatedat,token,clientClass,className,fcm;
  Country country;
  City city;
  int status;
  Image image;
  double average,wallet;
  bool isTeacher;
  var grade;
  User({this.id, this.name, this.email, this.phone, this.createdat,
      this.updatedat, this.country, this.city, this.status,this.isTeacher});
  User.fromjson(json){
   if(json is Map){
     if(json.containsKey('id')) this.id=json['id'];
     if(json.containsKey('name'))   this.name=json['name'];
     if(json.containsKey('status'))   this.status=json['status'];
     if(json.containsKey('email')) this.email=json['email'];
     if(json.containsKey('phone')) this.phone=json['phone'];
     if(json.containsKey('wallet')) this.wallet=double.parse(json['wallet'].toString());
     if(json.containsKey('average')) this.average=double.parse('${json['average']}');
     if(json.containsKey('api_token'))  this.token=json['api_token'];
     if(json.containsKey('city'))  this.clientClass=json['city']['name'];
     if(json.containsKey('country'))  this.country=Country.fromjson(json['country']);
     if(json.containsKey('city'))  this.city=City.fromjson(json['city']);
     if(json.containsKey('created_at'))  this.createdat=json['created_at'];
     if(json.containsKey('updated_at')) this.updatedat=json['updated_at'];
     if(json.containsKey('grade')) this.grade=json['grade'];
     if(json.containsKey('images')){
       final im=json['images'];
       if(im is List && im.length>0){
         image=Image.fromJson(im[0]);
       }else{image=null;}
     }
     if(this.grade!=null){
       this.className=json['grade']['className'];
     }
     else{ this.className=null;}
     this.fcm=json['fcm']??"";

     if( json.containsKey("teacherAccount")){
       isTeacher=true;
     }else{
       isTeacher=false;
     }
   }
  }
  isStudent(){
    if(this.clientClass=="customers"){return true;}
    return false;
  }
  
  
 String getWallet(){
    return "${RoyalPriceFormat.getFormat(wallet)}  دينار عراقي ";
 }
}