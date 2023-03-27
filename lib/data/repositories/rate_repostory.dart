import 'package:ward/data/api/rate_api.dart';

class RateRepository {
  final RateApi _rateApi;

  RateRepository(
    this._rateApi,
  );
  Future rate({
    required int businessId,
    required int rating,
  }) {
    return _rateApi.rate(
      businessId: businessId,
      rating: rating,
    );
  }
}
