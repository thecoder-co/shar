import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shar/constants.dart';
import 'package:shar/domain/user.dart';
import 'package:shar/util/app_url.dart';
import 'package:shar/util/shared_preference.dart';
import 'dart:convert';
import 'package:get/get.dart';

Future logout() async {
  Uri url = Uri.parse(AppUrl.logout);
  User user = await UserPreferences().getUser();
  String token = user.refreshToken!;
  var data = json.encode({
    'refresh_token': token,
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
  //back
  Get.back();
  if (response.statusCode == 200) {
    UserPreferences().removeUser();
    Get.offAllNamed('/login');
    Get.snackbar(
      'Successful',
      'Logout successful',
      margin: EdgeInsets.all(20),
      duration: Duration(milliseconds: 2000),
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
    );
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
