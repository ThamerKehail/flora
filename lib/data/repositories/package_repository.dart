import 'package:ward/data/api/package_api.dart';
import 'package:ward/models/package_model.dart';

class PackageRepository {
  final PackageApi _packageApi;
  PackageRepository(this._packageApi);
  Future<List<Package>> getAllPackage(int busID) {
    return _packageApi.getAllPackage(busID);
  }
}
