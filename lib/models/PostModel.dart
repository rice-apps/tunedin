// import 'package:json_annotation/json_annotation.dart';

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['netID'] = netID;
    data['numLikes'] = numLikes;
    data['comments'] = comments;
    data['musicURL'] = musicURL;
    return data;
  }
}
