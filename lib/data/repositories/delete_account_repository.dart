import 'package:ward/data/api/delete_account_api.dart';

class DeleteAccountRepository {
  final DeleteAccountApi _deleteAccountApi;
  DeleteAccountRepository(this._deleteAccountApi);
  Future<String> deleteAccount() {
    return _deleteAccountApi.deleteAccount();
  }
}
