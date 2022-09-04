class NotificationSecret{
 String secret;
 var data;
 NotificationSecret(this.secret);
 NotificationSecret.initial(json){
    this.secret=json['Royalmsg'];
    this.data=json['Royaldata'];

 }
}