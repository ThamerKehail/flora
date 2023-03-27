import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/models/user_model.dart';

import '../../dio/dio_client.dart';
import '../../utils/const.dart';

class EditProfileApi {
  late final DioClient dioClient;
  EditProfileApi(this.dioClient);
  Future editProfile({
    required String fName,
    required String lName,
    required String email,
    required File img,
  }) async {
    var data = FormData.fromMap({
      'profile_image': await MultipartFile.fromFile(
        img.path,
        filename: 'pro-image',
      ),
      'Fname': fName,
      'Lname': lName,
      'email': email,
    });
    final dio = Dio();

    Response response;
    response =
        await dioClient.dio.post('api/account/updata/$userId', data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
    } else {
      return null!;
    }
  }
}
