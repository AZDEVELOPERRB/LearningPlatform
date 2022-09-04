import 'package:learningplatform_rb/Repos/RoyalProviderRepo/royal_provider_repo.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
class AnkiRepo extends RoyalProviderRepo{
  AnkiRepo(final String serviceId) : super(Api.buyAnki+serviceId);
}