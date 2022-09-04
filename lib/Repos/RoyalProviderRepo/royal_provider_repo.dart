
import 'package:learningplatform_rb/Repos/RoyalRepos/royal_repo.dart';
import 'package:learningplatform_rb/database/base_local.dart';

class RoyalProviderRepo extends RoyalRepo{
  RoyalProviderRepo(this.url):super(url,token:BaseLocal.token());
  final String url;
}