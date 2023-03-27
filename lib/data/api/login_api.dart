import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/models/user_model.dart';
import 'package:ward/utils/routes.dart';

import '../../dio/dio_client.dart';
import '../../utils/const.dart';

class LoginApi {
  late final DioClient dioClient;
  LoginApi(this.dioClient);
  Future login({
    required String mobile,
    required String password,
    required BuildContext context,
  }) async {
    final data = {
      'mobile': mobile,
      'password': password,
    };
    final dio = Dio();

    Response response;
    response = await dioClient.dio.post('api/login', data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
      print(body['success']);
      userId = body['data']['token']['tokenable_id'];
      messageUser = await body['success'];
      print(messageUser);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', userId);
      Navigator.of(context).pushReplacementNamed(AppRoutes.mainHomeScreen);
    } else if (response.statusCode == 404) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("please check phone or password"),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      return null!;
    }
  }
}
