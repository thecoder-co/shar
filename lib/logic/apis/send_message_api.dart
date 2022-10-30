import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shar/constants.dart';
import 'package:shar/domain/string_exception.dart';
import 'package:shar/signup/signup_page.dart';
import 'package:shar/user_page/user_page.dart';
import 'package:shar/util/app_url.dart';

import 'dart:convert';
import 'package:get/get.dart';

Future<bool> sendMessageApi({
  required String user,
  required String message,
}) async {
  try {
    Uri url = Uri.parse(AppUrl.sendMessage + '?user=$user');

    http.Response response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({"message": message}),
    );

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw StringException(data['message']);
    }
  } on TimeoutException {
    throw StringException('Request timed out');
  } on SocketException {
    throw StringException('Check your internet');
  }
}
