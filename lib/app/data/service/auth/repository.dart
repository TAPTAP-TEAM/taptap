import 'package:taptap/app/data/models/issue_token.dart';
import 'package:taptap/app/data/provider/api.dart';

class AuthRepository {
  final ApiProvider api;
  AuthRepository(this.api);

  login() => api.login();
}
