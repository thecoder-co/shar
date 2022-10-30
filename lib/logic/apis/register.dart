import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shar/constants.dart';
import 'package:shar/domain/string_exception.dart';
import 'package:shar/domain/user.dart';
import 'package:shar/logic/apis/login.dart';
import 'package:shar/util/app_url.dart';

import 'dart:convert';
import 'package:get/get.dart';

Future<LoginData> registerApi({
  required String username,
  required String password,
}) async {
  try {
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
