import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shar/constants.dart';
import 'package:shar/domain/user.dart';
import 'package:shar/util/app_url.dart';
import 'package:shar/util/shared_preference.dart';
import 'dart:convert';
import 'package:get/get.dart';

Future deleteMessage({
  String? messageId,
  String? username,
  String? sharecode,
}) async {
  Uri url = Uri.parse(AppUrl.delMessage);
  User user = await UserPreferences().getUser();
  String token = user.accessToken!;

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
  http.Response response = await http.delete(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: json.encode({"message_id": messageId}),
  );
  Get.back();
  if (response.statusCode == 200) {
    Get.toNamed(
      '/get_messages',
      parameters: {
        'username': username!,
        'shareCode': sharecode!,
      },
      preventDuplicates: false,
    );

    Get.snackbar(
      'Successful',
      'Deleted Message Successfully',
      margin: EdgeInsets.all(20),
      duration: Duration(milliseconds: 2000),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
    );
  } else {
    Get.snackbar(
      'Error',
      'Message not found',
      margin: EdgeInsets.all(20),
      duration: Duration(milliseconds: 2000),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
