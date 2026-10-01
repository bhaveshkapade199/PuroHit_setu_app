import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _storage = GetStorage();

  void saveToken(String token) {
    _storage.write('token', token);
  }

  String? getToken() {
    return _storage.read<String>('token');
  }

  void removeToken() {
    _storage.remove('token');
  }

  void clearAll() {
    _storage.erase();
  }
}
