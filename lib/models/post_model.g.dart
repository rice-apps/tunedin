// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      netID: json['netID'] as String,
      numLikes: json['numLikes'] as int,
      bodyText: json['bodyText'] as String,
      musicURL: json['musicURL'] as String,
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'netID': instance.netID,
      'numLikes': instance.numLikes,
      'bodyText': instance.bodyText,
      'musicURL': instance.musicURL,
    };
