import 'package:shar/domain/user.dart';
import 'package:shar/util/app_url.dart';
import 'package:shar/util/shared_preference.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<UserInfo> getUserInfo() async {
  Uri url = Uri.parse(AppUrl.userInfo);
  User user = await UserPreferences().getUser();
  String token = user.accessToken!;

  http.Response response = await http.get(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    UserInfo data = userInfoFromJson(response.body);
    return data;
  } else {
    throw Exception('Unable to load data');
  }
}

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.data,
  });

  Data? data;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.username,
    this.shareCode,
  });

  String? username;
  String? shareCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        shareCode: json["share_code"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "share_code": shareCode,
      };
}
