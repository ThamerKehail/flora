import 'package:ward/data/api/address_api.dart';

class AddressRepository {
  final AddressApi _addressApi;

  AddressRepository(
    this._addressApi,
  );
  Future address({
    required String city,
    required String address,
    required String streetName,
    required int building,
    required int floor,
    required String mobile,
    required String note,
    required int userId,
    required int status,
    required int business_id,
  }) {
    return _addressApi.address(
      city: city,
      status: status,
      business_id: business_id,
      address: address,
      streetName: streetName,
      building: building,
      floor: floor,
      mobile: mobile,
      userId: userId,
      note: note,
    );
  }
}
