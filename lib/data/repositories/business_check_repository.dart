import 'package:ward/data/api/business_check_api.dart';

class CheckBusinessRepository {
  final CheckBusinessApi _businessApi;

  CheckBusinessRepository(
    this._businessApi,
  );
  Future checkBusiness({
    required int orderId,
  }) {
    return _businessApi.checkBusiness(
      orderId: orderId,
    );
  }
}
