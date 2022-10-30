import 'dart:async';
import 'dart:io';

import 'package:shar/domain/shared_preference.dart';
import 'package:shar/domain/string_exception.dart';
import 'package:shar/util/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:get/get.dart';

Future<Profile> getProfileApi() async {
  try {
    final response = await http.get(
      Uri.parse(AppUrl.getUser),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${UserPreferences.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      return profileFromJson(response.body);
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

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.statusCode,
    this.body,
  });

  int? statusCode;
  Body? body;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "body": body == null ? null : body?.toJson(),
      };
}

class Body {
  Body({
    this.username,
    this.messages,
  });

  String? username;
  List<Message>? messages;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        username: json["username"] == null ? null : json["username"],
        messages: json["messages"] == null
            ? null
            : List<Message>.from(
                json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "messages": messages == null
            ? null
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    this.message,
    this.time,
    this.id,
  });

  String? message;
  double? time;
  String? id;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json["message"] == null ? null : json["message"],
        time: json["time"] == null ? null : json["time"].toDouble(),
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "time": time == null ? null : time,
        "_id": id == null ? null : id,
      };
}
