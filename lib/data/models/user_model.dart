import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String? netID;
  String? name;
  String? handle;
  String? token;

  UserModel(
      {required this.netID,
      required this.name,
      required this.handle,
      required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        netID: json['netid'],
        name: json['name'],
        handle: json['handle'],
        token: json['token']);
  }

  Map<String, dynamic> toJson() =>
      {'netid': netID, 'name': name, 'handle': handle, 'token': token};
}
