import 'package:ward/data/api/send_email_api.dart';

class SendEmailRepository {
  final SendEmailApi _sendEmailApi;

  SendEmailRepository(
    this._sendEmailApi,
  );
  Future sendEmail({
    required String name,
    required String email,
    required String toEmail,
    required String subject,
    required String message,
  }) {
    return _sendEmailApi.sendEmail(
      name: name,
      message: message,
      email: email,
      subject: subject,
      toEmail: toEmail,
    );
  }
}
