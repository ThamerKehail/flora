import '../../models/avg_business_rate.dart';
import '../api/avg_business_rate.dart';

class AvgBusinessRepository {
  final AvgBusinessApi _avgBusinessApi;
  AvgBusinessRepository(this._avgBusinessApi);
  Future<AvgBusinessRate> getAllUsers(int businessId) {
    return _avgBusinessApi.getAvgRate(businessId);
  }
}
