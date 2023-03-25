import 'package:freezed_annotation/freezed_annotation.dart';
part 'song_model.freezed.dart';
part 'song_model.g.dart';

@unfreezed
class SongModel with _$SongModel {
  factory SongModel({
    required String id,
  }) = _SongModel;

  factory SongModel.fromJson(Map<String, dynamic> json) =>
      _$SongModelFromJson(json);
}