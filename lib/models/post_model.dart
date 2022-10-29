import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@unfreezed
class PostModel with _$PostModel {
  factory PostModel({
    required String netID,
    required int numLikes,
    required String bodyText,
    // required var comments,
    required String musicURL,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}