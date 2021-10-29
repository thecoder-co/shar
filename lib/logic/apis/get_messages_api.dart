import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shar/domain/user.dart';
import 'package:shar/util/app_url.dart';
import 'package:shar/util/shared_preference.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future getMessages() async {
  Uri url = Uri.parse(AppUrl.getMessages);
  User user = await UserPreferences().getUser();
  String token = user.accessToken!;

  http.Response response = await http.get(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    UserMessages data = userMessagesFromJson(response.body);
    return data;
  } else {
    throw Exception();
  }
}

UserMessages userMessagesFromJson(String str) =>
    UserMessages.fromJson(json.decode(str));

String userMessagesToJson(UserMessages data) => json.encode(data.toJson());

class UserMessages {
  UserMessages({
    this.messages,
  });

  List<Message>? messages;

  factory UserMessages.fromJson(Map<String, dynamic> json) => UserMessages(
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    this.id,
    this.content,
    this.created,
  });

  int? id;
  String? content;
  DateTime? created;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        content: json["content"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "created": created!.toIso8601String(),
      };
}
