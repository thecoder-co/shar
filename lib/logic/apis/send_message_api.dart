import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shar/domain/user.dart';
import 'package:shar/send_message/send_message.dart';
import 'package:shar/signup/signup_page.dart';
import 'package:shar/user_page/user_page.dart';
import 'package:shar/util/app_url.dart';
import 'package:shar/util/shared_preference.dart';
import 'dart:convert';
import 'package:get/get.dart';

Future sendMessage({
  required String? shareCode,
  required String? message,
}) async {
  Uri url = Uri.parse(AppUrl.sendMessage + shareCode! + '/');

  http.Response response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: json.encode({"message": message}),
  );
  if (response.statusCode == 200) {
    if (!await UserPreferences().isLoggedIn()) {
      Get.off(
        () => SignupPage(),
      );
      Get.snackbar(
        'Successful',
        "Now, It's your turn. Create an account and recieve anonymous messages",
        margin: EdgeInsets.all(20),
        duration: Duration(milliseconds: 5000),
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
      );
    } else {
      Get.off(
        () => MainUserPage(),
      );
      Get.snackbar(
        'Successful',
        'Message sent successfully',
        margin: EdgeInsets.all(20),
        duration: Duration(milliseconds: 2000),
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
      );
    }
  } else {
    Get.snackbar(
      'Error',
      'Unable to send message',
      margin: EdgeInsets.all(20),
      duration: Duration(milliseconds: 2000),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
