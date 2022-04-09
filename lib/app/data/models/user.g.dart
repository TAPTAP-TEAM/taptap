// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      fintechUseNum: json['fintechUseNum'] as String,
      accountAlias: json['accountAlias'] as String,
      bankCodeStd: json['bankCodeStd'] as String,
      backCodeSub: json['backCodeSub'] as String,
      bankName: json['bankName'] as String,
      accountHolderName: json['accountHolderName'] as String,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'fintechUseNum': instance.fintechUseNum,
      'accountAlias': instance.accountAlias,
      'bankCodeStd': instance.bankCodeStd,
      'backCodeSub': instance.backCodeSub,
      'bankName': instance.bankName,
      'accountHolderName': instance.accountHolderName,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      userSeqNo: json['userSeqNo'] as String,
      userName: json['userName'] as String,
      accounts: (json['accounts'] as List<dynamic>)
          .map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'userSeqNo': instance.userSeqNo,
      'userName': instance.userName,
      'accounts': instance.accounts,
    };
