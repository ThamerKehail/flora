import 'package:ward/models/category_model.dart';

import '../api/category_api.dart';

class CategoryRepository {
  final CategoryApi _categoryApi;
  CategoryRepository(this._categoryApi);
  Future<List<CategoryModel>> getAllCategory() {
    return _categoryApi.getAllCategory();
  }
}
