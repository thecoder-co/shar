import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shar/domain/user.dart';
import 'package:shar/user_page/user_page.dart';
import 'package:shar/util/app_url.dart';
import 'package:shar/util/shared_preference.dart';
import 'dart:convert';
import 'package:get/get.dart';

Future register({
  String? username,
  String? password,
}) async {
  Uri url = Uri.parse(AppUrl.register);
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
    RegisterUser user = registerUserFromJson(response.body);
    UserPreferences().saveUser(
      User(
        accessToken: user.tokens!.access,
        refreshToken: user.tokens!.refresh,
      ),
    );
    Get.off(() => MainUserPage());
    Get.snackbar(
      'Successful',
      'User created successfully',
      margin: EdgeInsets.all(20),
      duration: Duration(milliseconds: 2000),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
    );
  } else {
    if (response.statusCode == 400) {
      Map user = jsonDecode(response.body);
      Get.snackbar(
        'Error',
        user["detail"]!,
        margin: EdgeInsets.all(20),
        duration: Duration(milliseconds: 2000),
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
      );
    } else {
      Get.snackbar(
        'Error',
        'Unable to register user',
        margin: EdgeInsets.all(20),
        duration: Duration(milliseconds: 2000),
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
      );
    }
  }
}

RegisterUser registerUserFromJson(String str) =>
    RegisterUser.fromJson(json.decode(str));

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
  RegisterUser({
    this.detail,
    this.tokens,
  });

  String? detail;
  Tokens? tokens;

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        detail: json["detail"],
        tokens: Tokens.fromJson(json["tokens"]!),
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
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
