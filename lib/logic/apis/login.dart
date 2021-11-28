import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shar/constants.dart';
import 'package:shar/domain/user.dart';
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
  Get.defaultDialog(
    backgroundColor: kPrimaryColor,
    content: CircularProgressIndicator(
      color: kGold,
    ),
    radius: 10,
    title: 'Loading',
    titleStyle: GoogleFonts.getFont(
      'Overlock',
      textStyle: TextStyle(
        fontSize: 16,
        color: kGold,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
  http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: data,
  );
  Get.back();
  if (response.statusCode == 200) {
    LoginData data = loginDataFromJson(response.body);
    UserPreferences()
        .saveUser(
      User(
        accessToken: data.tokens!.access,
        refreshToken: data.tokens!.refresh,
      ),
    )
        .then((value) {
      Get.offAllNamed('/home');
      Get.snackbar(
        'Successful',
        'Login successful',
        margin: EdgeInsets.all(20),
        duration: Duration(milliseconds: 2000),
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
      );
    });
  } else {
    print(response.body);
    Map user = jsonDecode(response.body);
    Get.snackbar(
      'Error',
      user['detail'],
      margin: EdgeInsets.all(20),
      duration: Duration(milliseconds: 2000),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
    );
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
