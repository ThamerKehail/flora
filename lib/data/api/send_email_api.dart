import 'package:dio/dio.dart';

import '../../dio/dio_client.dart';

class SendEmailApi {
  late final DioClientEmail dioClient;
  final serviceId = "service_k17c1l8";
  final templateId = "template_dczwm57";
  final userID = "qYnzSqp9oxY71jrLD";
  SendEmailApi(this.dioClient);
  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
    required String toEmail,
  }) async {
    final data = {
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userID,
      'template_params': {
        'user_name': name,
        'user_email': email,
        'to_email': toEmail,
        'user_subject': subject,
        'user_message': message,
      },
    };
    final dio = Dio();

    Response response;
    response = await dioClient.dio.post('send',
        data: data,
        options: Options(
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json',
          },
        ));
    if (response.statusCode == 200) {
      final body = response.data;
      print(body);
    } else {
      return null!;
    }
  }
}
