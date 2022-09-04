class RS{
  String status,msg,toast;
  var data;
  RS({this.status, this.msg,this.toast,this.data});
  RS.fromJson(json){
    this.status="${json['status']}";
    this.msg="${json['msg']}";
    this.data=json['data'];
    this.toast="${json['toast']}";
  }


  check<bool>(){
    if(this.status=="success"||status=="Success"){
      return true;
    }
    return false;
  }
  
  
  Auth(){
      if(this.msg=="not_auth"||this.msg=="not_Auth"){
        return false;
      }
      return true;
  }
  
  saveAuth(){
    if(this.msg=="Auth"||this.msg=="auth"||this.msg=="not_auth"||this.msg=="not_Auth"){
      return true;
    }
    return false;
  }
  RoyalToast(){
    if(this.toast!="no_toast"){
      return true;
    }
    return false;
  }

  toMap(){
    return{
      "status":this.status,
      "msg":this.msg,
      "data":this.data,
      "toast":this.toast,
    };
  }
}