import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post_model.freezed.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required String netID,
    // required int numLikes,
    required String bodyText,
    // required var comments,
    required String musicURL,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

class PostModel {
  String netID = "";
  int numLikes = 0;
  String bodyText = "";
  var comments = [];
  String musicURL = "";
  // ...

  PostModel(
      {required this.netID, required this.bodyText, required this.musicURL});

  PostModel.fromJson(Map<String, dynamic> json) {
    netID = json['netID'];
    numLikes = json['numLikes'];
    comments = json['comments'];
    musicURL = json['musicURL'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['netID'] = netID;
    data['numLikes'] = numLikes;
    data['comments'] = comments;
    data['musicURL'] = musicURL;
    return data;
  }
}
