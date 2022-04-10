import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:taptap/app/data/models/issue_token.dart';
import 'package:taptap/app/routes/routes.dart';
import 'package:taptap/app/data/service/auth/repository.dart';
import 'package:taptap/app/data/provider/api.dart';

class AuthService extends GetxService {
  late AuthRepository repository;
  final FlutterSecureStorage _storage = Get.find<FlutterSecureStorage>();
  final _token = ''.obs;
  final _seq_no = ''.obs;

  final TOKEN_KEY = "accessToken";
  final USER_NO = "seq_no";

  String get token => _token.value;
  String get seq_no => _seq_no.value;

  _setToken(String token, String seq_no) async {
    _token.value = token;
    _seq_no.value = seq_no;
    await _storage.write(key: TOKEN_KEY, value: token);
    await _storage.write(key: USER_NO, value: seq_no);
  }

  _removeToken() async {
    _token.value = '';
    await _storage.deleteAll();

    Get.offAllNamed(Routes.LOGIN);
  }

  Future<AuthService> init() async {
    repository = AuthRepository(ApiProvider());
    String? tokenInStorage = await _storage.read(key: TOKEN_KEY);
    String? seqNoInStorage = await _storage.read(key: USER_NO);
    if (tokenInStorage != null && tokenInStorage != " ") {
      _token.value = tokenInStorage;
    }
    if (seqNoInStorage != null && seqNoInStorage != " ") {
      _seq_no.value = seqNoInStorage;
    }
    return this;
  }

  Future<void> login() async {
    IssueTokenResponse response = await repository.login();

    String? token = response.accessToken;
    String? _seq_no = response.userSeqNo;
    if (token != null) await _setToken(token, _seq_no);
  }

  logout() async {
    await _removeToken();
  }
}
