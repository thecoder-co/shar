import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  static late SharedPreferences prefs;
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future saveToken(String token) async {
    prefs.setString("token", token);
  }

  static Future clearData() async {
    prefs.clear();
  }

  static String? getToken() {
    String? token = prefs.getString("token");

    return token;
  }

  static bool isLoggedIn() {
    var token = prefs.get("token") ?? false;
    if (token != false) {
      return true;
    } else {
      return false;
    }
  }

  static void removeToken() async {
    prefs.remove("token");
  }
}
