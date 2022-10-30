import 'dart:async';
import 'dart:io';

import 'package:shar/domain/shared_preference.dart';
import 'package:shar/domain/string_exception.dart';
import 'package:shar/util/app_url.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

Future<bool> deleteMessageApi({
  required String id,
}) async {
  try {
    final response = await http.post(Uri.parse(AppUrl.delMessage),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserPreferences.getToken()}'
        },
        body: json.encode({"id": id}));
    if (response.statusCode == 200) {
      return true;
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
