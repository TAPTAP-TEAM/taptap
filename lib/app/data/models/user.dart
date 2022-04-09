import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class Account {
  final String fintech_useNum;
  final String account_alias;
  final String bank_name;
  final String account_num_masked;

  Account(
      {required this.fintech_useNum,
      required this.account_alias,
      required this.bank_name,
      required this.account_num_masked});
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class UserInfo {
  final String user_seq_no;
  final String user_name;
  final List<Account> res_list;
  UserInfo(
      {required this.user_seq_no,
      required this.user_name,
      required this.res_list});
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
