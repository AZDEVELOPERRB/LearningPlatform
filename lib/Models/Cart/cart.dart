import 'package:learningplatform_rb/Models/Pricabe/priceable.dart';

class Cart extends Priceable{
  String id,serviceId,serviceName;

  Cart.fromJson(final dynamic json){
    if(json is Map){
      id=json['id'];
      if(json.containsKey("service_id"))serviceId=json['service_id'];
      if(json.containsKey("service_name"))serviceName=json['service_name'];
      formPrice(json);
    }
  }
}