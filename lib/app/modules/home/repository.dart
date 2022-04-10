import 'package:taptap/app/data/models/user.dart';
import 'package:taptap/app/data/provider/api.dart';

class UserRepository {
  final ApiProvider api;
  UserRepository(this.api);
  Future<UserInfo?> getUserInfo() => api.getUserInfo();
}
