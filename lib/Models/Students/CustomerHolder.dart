class CustomerHolder{
  String name;
  String password;
  String email;
  String phone;
  String Countryid;
  String city;
  String fcm;
  toMap(){
    return {
      "name":this.name,
      "password":this.password,
      "phone":this.phone,
      "email":this.email,
      "Country":this.Countryid,
      "state":this.city,
      "fcm":this.fcm,
    };
  }
}