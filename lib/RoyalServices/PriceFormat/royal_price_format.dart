import 'package:intl/intl.dart';

class RoyalPriceFormat{

static  final value = new NumberFormat("#,##0", "en_US");
static getFormat(final double price){
  return value.format(price);
}
}