import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';
import 'package:learningplatform_rb/RoyalServices/PriceFormat/royal_price_format.dart';

class Priceable extends RoyalGeneralModel{
  double price;

  formPrice(final dynamic json){
    if(json is Map && json.containsKey("price")){
      price=double.parse(json['price'].toString());
    }
  }

  String getPrice(){
    return "${RoyalPriceFormat.getFormat(price)} دينار عراقي ";
  }
}
