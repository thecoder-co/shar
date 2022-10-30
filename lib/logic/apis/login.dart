import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shar/domain/string_exception.dart';
import 'package:shar/util/app_url.dart';

import 'dart:convert';

Future<LoginData> loginApi({
  required String username,
  required String password,
}) async {
  try {
    Uri url = Uri.parse(AppUrl.login);
    var data = json.encode({
      'username': username,
      'password': password,
    });

    http.Response response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: data,
    );
    if (response.statusCode == 200) {
      return loginDataFromJson(response.body);
    } else {
      final resdata = json.decode(response.body);
      throw StringException(resdata['message']);
    }
  } on TimeoutException {
    throw StringException('Request timed out');
  } on SocketException {
    throw StringException('Check your internet');
  }
}

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.statusCode,
    this.message,
    this.accessToken,
  });

  int? statusCode;
  String? message;
  String? accessToken;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "access_token": accessToken == null ? null : accessToken,
      };
}
