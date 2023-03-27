import 'package:ward/data/api/business_color_api.dart';
import 'package:ward/data/api/business_rated_api.dart';
import 'package:ward/models/business_color_model.dart';

import '../../models/business_rated_model.dart';

class BusinessColorRepository {
  final BusinessColorApi _businessColorApi;
  BusinessColorRepository(this._businessColorApi);
  Future<List<BusinessColors>> getAllBusinessColors({required int businessId}) {
    return _businessColorApi.getAllBusinessColors(
        businessId: businessId.toString());
  }
}
