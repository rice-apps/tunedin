import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String? netID;
  String? displayName;
  String? userName;

  List<UserModel>? following;
  List<UserModel>? followers;

  String? token;

  UserModel(
      {required this.netID,
      required this.displayName,
      required this.userName,
      required this.following,
      required this.followers,
      required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        netID: json['netid'],
        displayName: json['displayname'],
        userName: json['username'],
        following: json['following'],
        followers: json['followers'],
        token: json['token']);
  }

  Map<String, dynamic> toJson() => {
        'netid': netID,
        'displayname': displayName,
        'username': userName,
        'following': following,
        'followers': followers,
        'token': token
      };

  void followUser(UserModel targetUser) {
    following?.add(targetUser);
  }
}
