import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class Account {
  final String fintechUseNum;
  final String accountAlias;
  final String bankCodeStd;
  final String backCodeSub;
  final String bankName;
  final String accountHolderName;

  Account(
      {required this.fintechUseNum,
      required this.accountAlias,
      required this.bankCodeStd,
      required this.backCodeSub,
      required this.bankName,
      required this.accountHolderName});
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class UserInfo {
  final String userSeqNo;
  final String userName;
  final List<Account> accounts;
  UserInfo(
      {required this.userSeqNo,
      required this.userName,
      required this.accounts});
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
