import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String? netID;
  String? displayName;
  String? userName;

  List<UserModel>? following;

  UserModel({
    required this.netID,
    required this.displayName,
    required this.userName,
    required this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        netID: json['netID'],
        displayName: json['displayName'],
        userName: json['userName'],
        following: json['following']);
  }

  Map<String, dynamic> toJson() =>
      {'name': displayName, 'userName': userName, 'following': following};
  void followUser(UserModel targetUser) {
    following?.add(targetUser);
  }
}
