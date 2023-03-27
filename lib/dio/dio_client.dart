import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options.baseUrl = 'http://www.florajo.com/';
    //  _dio.options.baseUrl = 'http://10.0.2.2/dashboard_flower/public/';
  }

  Dio get dio => _dio;
}

class DioClientEmail {
  final Dio _dio = Dio();

  DioClientEmail() {
    _dio.options.baseUrl = 'https://api.emailjs.com/api/v1.0/email/';
  }

  Dio get dio => _dio;
}
