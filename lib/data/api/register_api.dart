import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ward/view/pages/login_page/login_page.dart';

import '../../dio/dio_client.dart';
import '../../utils/global.dart';

class RegisterApi {
  late final DioClient dioClient;
  RegisterApi(this.dioClient);
  Future register({
    required String email,
    required String fname,
    required String lname,
    required String mobile,
    required String password,
    required BuildContext context,
  }) async {
    final data = {
      'Fname': fname,
      'Lname': lname,
      'email': email,
      'city': '0',
      'mobile': mobile,
      'is_admin': '2',
      'business_Description': 'description',
      'category': '0',
      'state': '0',
      'long': '0',
      'lat': '0',
      'from': '0',
      'to': '1',
      'cover': 'cover',
      'password': password,
      'profile_image': 'na',
      'address': 'na',
    };
    final dio = Dio();

    Response response;
    response = await dioClient.dio.post('api/register', data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      print(body['data']['token']['tokenable_id']);
      print(body);
      userId = body['data']['token']['tokenable_id'];
      print(userId);
      messageUser = await body['success'];
      print(messageUser);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', userId);
      print("==================Shared pref====================");
      print(userId.toString());
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    } else {
      return null!;
    }

    // try {
    //   final response = await dioClient.dio.post('api/register', data: {
    //     'Fname': 'thamer',
    //     'Lname': 'kehail',
    //     'mobile': '0786007814',
    //     'email': 'thamer@gmail.com',
    //     'password': '123456789',
    //     'profile_image': 'na',
    //   });
    //   return response.data;
    // } catch (e) {
    //   print(e);
    //   return Future.error(e);
    // }
  }
}
