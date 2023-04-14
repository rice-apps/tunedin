// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      id: json['id'] as String,
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      likedBy:
          (json['likedBy'] as List<dynamic>).map((e) => e as String).toList(),
      numLikes: json['numLikes'] as int?,
      comments:
          (json['comments'] as List<dynamic>).map((e) => e as String).toList(),
      bodyText: json['bodyText'] as String,
      musicURL: json['musicURL'] as String,
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'likedBy': instance.likedBy,
      'numLikes': instance.numLikes,
      'comments': instance.comments,
      'bodyText': instance.bodyText,
      'musicURL': instance.musicURL,
    };
