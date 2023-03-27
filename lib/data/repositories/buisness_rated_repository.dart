import 'package:ward/data/api/business_rated_api.dart';

import '../../models/business_rated_model.dart';

class BusinessRatedRepository {
  final BusinessRatedApi _businessRatedApi;
  BusinessRatedRepository(this._businessRatedApi);
  Future<List<BusinessRated>> getAllBusiness() {
    return _businessRatedApi.getAllBusinessRate();
  }
}
