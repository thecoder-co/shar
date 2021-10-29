import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shar/domain/user.dart';
import 'package:shar/user_page/user_page.dart';
import 'package:shar/util/app_url.dart';
import 'package:shar/util/shared_preference.dart';
import 'dart:convert';
import 'package:get/get.dart';

Future login({
  String? username,
  String? password,
}) async {
  Uri url = Uri.parse(AppUrl.login);
  var data = json.encode({
    'username': username,
    'password': password,
  });
  print(data);
  http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: data,
  );
  if (response.statusCode == 200) {
    print(response.body);
    LoginData data = loginDataFromJson(response.body);
    UserPreferences().saveUser(
      User(
        accessToken: data.tokens!.access,
        refreshToken: data.tokens!.refresh,
      ),
    );
    Get.off(() => MainUserPage());
    Get.snackbar(
      'Successful',
      'Login successful',
      margin: EdgeInsets.all(20),
      duration: Duration(milliseconds: 2000),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
    );
  } else {
    print(response.body);
    print(response.statusCode);
    Get.snackbar(
      'Error',
      'Unable to login',
      margin: EdgeInsets.all(20),
      duration: Duration(milliseconds: 2000),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
    );

    throw Exception('Unable to load data');
  }
}

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.tokens,
  });

  Tokens? tokens;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "tokens": tokens!.toJson(),
      };
}

class Tokens {
  Tokens({
    this.refresh,
    this.access,
  });

  String? refresh;
  String? access;

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
