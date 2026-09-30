import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _storage = GetStorage();

  void saveToken(String token) {
    _storage.write('token', token);
  }

  String? getToken() {
    return _storage.read<String>('token');
  }

  void saveUserId(String userId) {
    _storage.write('user_id', userId);
  }

  String? getUserId() {
    return _storage.read<String>('user_id');
  }

  void savePhone(String phone) {
    _storage.write('phone', phone);
  }

  String? getPhone() {
    return _storage.read<String>('phone');
  }

  void removeToken() {
    _storage.remove('token');
  }

  void clearAll() {
    _storage.erase();
  }
}
