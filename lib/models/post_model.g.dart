// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      id: json['id'] as String,
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      numLikes: json['numLikes'] as num,
      bodyText: json['bodyText'] as String,
      musicURL: json['musicURL'] as String,
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'numLikes': instance.numLikes,
      'bodyText': instance.bodyText,
      'musicURL': instance.musicURL,
    };
