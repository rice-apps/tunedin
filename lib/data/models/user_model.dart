import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String? netID;
  String? name;
  String? handle;

  List<UserModel>? following;
  List<UserModel>? followers;

  String? token;

  UserModel(
      {required this.netID,
      required this.name,
      required this.handle,
      required this.following,
      required this.followers,
      required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        netID: json['netid'],
        name: json['name'],
        handle: json['handle'],
        following: json['following'],
        followers: json['followers'],
        token: json['token']);
  }

  Map<String, dynamic> toJson() => {
        'netid': netID,
        'name': name,
        'handle': handle,
        'following': following,
        'followers': followers,
        'token': token
      };

  void followUser(UserModel targetUser) {
    following?.add(targetUser);
  }
}
