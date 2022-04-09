import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:taptap/app/data/service/auth/repository.dart';
import 'package:taptap/app/data/provider/api.dart';

class AuthService extends GetxService {
  late AuthRepository repository;
  final FlutterSecureStorage _storage = Get.find<FlutterSecureStorage>();
  final _token = ''.obs;

  final STOARGE_KEY = "accessToken";

  String get token => _token.value;

  _setToken(String token) async {
    _token.value = token;
    await _storage.write(key: STOARGE_KEY, value: token);
  }

  _removeToken() async {
    _token.value = '';
    await _storage.delete(key: STOARGE_KEY);
  }

  init() async {
    repository = AuthRepository(ApiProvider());
    String? tokenInStorage = await _storage.read(key: STOARGE_KEY);
    if (tokenInStorage != null && tokenInStorage != " ") {
      _token.value = tokenInStorage;
    }
    return this;
  }

  login() async {
    String? token = await repository.login();
    if (token != null) await _setToken(token);
  }

  logout() async {
    await _removeToken();
  }
}
