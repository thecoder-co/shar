import 'package:shar/send_message/send_message.dart';
import 'package:shar/util/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:get/get.dart';

Future findUser({
  required String? shareCode,
}) async {
  Uri url = Uri.parse(AppUrl.getUser + shareCode! + '/');

  http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    GetUsername data = getUsernameFromJson(response.body);
    Get.off(
      () => SendMessagePage(
        username: data.username,
        shareCode: shareCode,
      ),
    );
  } else {
    Get.snackbar(
      'Error',
      'Unable to find user',
      margin: EdgeInsets.all(20),
      duration: Duration(milliseconds: 2000),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}

GetUsername getUsernameFromJson(String str) =>
    GetUsername.fromJson(json.decode(str));

String getUsernameToJson(GetUsername data) => json.encode(data.toJson());

class GetUsername {
  GetUsername({
    this.detail,
    this.username,
  });

  String? detail;
  String? username;

  factory GetUsername.fromJson(Map<String, dynamic> json) => GetUsername(
        detail: json["detail"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
        "username": username,
      };
}
