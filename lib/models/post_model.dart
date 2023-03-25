import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:rice_music_sharing/models/user_model.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@unfreezed
class PostModel with _$PostModel {
  factory PostModel({
    required String id,
    required UserModel author,
    required num numLikes,
    required String bodyText,
    required String musicURL,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
