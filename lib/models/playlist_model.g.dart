// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlaylistModel _$$_PlaylistModelFromJson(Map<String, dynamic> json) =>
    _$_PlaylistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      songs: (json['songs'] as List<dynamic>)
          .map((e) => SongModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PlaylistModelToJson(_$_PlaylistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'songs': instance.songs,
    };
