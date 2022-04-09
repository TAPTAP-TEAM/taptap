// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      fintech_useNum: json['fintech_useNum'] as String,
      account_alias: json['account_alias'] as String,
      bank_name: json['bank_name'] as String,
      account_num_masked: json['account_num_masked'] as String,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'fintech_useNum': instance.fintech_useNum,
      'account_alias': instance.account_alias,
      'bank_name': instance.bank_name,
      'account_num_masked': instance.account_num_masked,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      user_seq_no: json['user_seq_no'] as String,
      user_name: json['user_name'] as String,
      res_list: (json['res_list'] as List<dynamic>)
          .map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'user_seq_no': instance.user_seq_no,
      'user_name': instance.user_name,
      'res_list': instance.res_list,
    };
