import 'package:ward/data/api/flowers_places_api.dart';
import 'package:ward/data/api/product_api.dart';
import 'package:ward/models/places_model.dart';
import 'package:ward/models/product_model.dart';

class ProductRepository {
  final ProductApi _productApi;

  ProductRepository(
    this._productApi,
  );
  Future<List<Product>> getAllProduct(int businessId) {
    return _productApi.getAllProduct(businessId);
  }
}
