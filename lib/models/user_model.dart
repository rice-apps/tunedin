import 'package:json_annotation/json_annotation.dart';

/// Class with represents the user model.
///
/// Holds all data pertaining to a single user.
@JsonSerializable(explicitToJson: true)
class UserModel {
  String? netID;
  String? displayName;
  String? userName;
  // String? email;
  // String? college;
  List<UserModel>? following;

  UserModel({
    required this.netID,
    required this.displayName,
    required this.userName,
    // required this.email,
    // required this.college,
    required this.following,
  });

  //User(this.name, this.email, this.userName, this.college)

  // UserModel(this.email, this.userName, this.name, this.College);

  //User.fromJson(Map<String, dynamic> json)

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        netID: json['netID'],
        displayName: json['displayName'],
        userName: json['userName'],
        following: json['following']);
  }

  Map<String, dynamic> toJson() => {
        'name': displayName,
        // 'email': email,
        'userName': userName,
        // 'college': college,
        'following': following
      };
  void followUser(UserModel targetUser) {
    following?.add(targetUser);
  }
}
