import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@unfreezed
class GroupModel with _$GroupModel {
  const GroupModel._();
  factory GroupModel({
    String? displayName,
    String? userName,
    String? email,
    String? admin, // change to UserModel later
    List<String>? followers, // change to UserModel later
    List<String>? members, // change to UserModel later
  }) = _GroupModel;

  void addFollower(String follower) {
    followers?.add(follower);
  }

  void addMember(String member) {
    followers?.add(member);
  }

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);
}
