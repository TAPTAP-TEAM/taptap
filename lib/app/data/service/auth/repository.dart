import 'package:taptap/app/data/provider/api.dart';

class AuthRepository {
  final ApiProvider api;
  AuthRepository(this.api);

  login() => api.authorize();
}
