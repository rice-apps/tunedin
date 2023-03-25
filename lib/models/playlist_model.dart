import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rice_music_sharing/models/song_model.dart';
part 'playlist_model.freezed.dart';
part 'playlist_model.g.dart';

@unfreezed
class PlaylistModel with _$PlaylistModel {
  factory PlaylistModel({
    required String id,
    required String name,
    required List<SongModel> songs,
  }) = _PlaylistModel;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) =>
      _$PlaylistModelFromJson(json);
}