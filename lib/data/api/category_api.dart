import 'package:flutter/foundation.dart';
import 'package:ward/models/category_model.dart';

import '../../dio/dio_client.dart';
import '../../models/places_model.dart';

class CategoryApi {
  final DioClient dioClient;
  CategoryApi(this.dioClient);
  Future<List<CategoryModel>> getAllCategory() async {
    try {
      final response = await dioClient.dio.get('api/categorie_all');
      print(CategoryModel.asListFromJson(response.data));
      return CategoryModel.asListFromJson(response.data);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
