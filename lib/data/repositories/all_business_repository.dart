import 'package:ward/data/api/all_business_rate.dart';

import '../../models/all_business_rate.dart';

class AllBusinessRepository {
  final AllBusinessRateApi _allBusinessRateApi;
  AllBusinessRepository(this._allBusinessRateApi);
  Future<List<AllBusinessRate>> getAllBusiness() {
    return _allBusinessRateApi.getAllBusinessRate();
  }
}
