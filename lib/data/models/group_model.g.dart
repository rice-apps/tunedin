// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupModel _$$_GroupModelFromJson(Map<String, dynamic> json) =>
    _$_GroupModel(
      displayName: json['displayName'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      admin: json['admin'] as String?,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      members:
          (json['members'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_GroupModelToJson(_$_GroupModel instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'userName': instance.userName,
      'email': instance.email,
      'admin': instance.admin,
      'followers': instance.followers,
      'members': instance.members,
    };
