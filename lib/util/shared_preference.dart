import 'package:shar/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("refreshToken", user.refreshToken!);
    prefs.setString("accessToken", user.accessToken!);
  }

  Future<User> getUser() async {
    String? accessToken;
    String? refreshToken;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    accessToken = prefs.getString("accessToken");
    refreshToken = prefs.getString("refreshToken");

    return User(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("refreshToken") ?? false;
    if (token != false) {
      return true;
    } else {
      return false;
    }
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("refreshToken");
    prefs.remove("accessToken");
    prefs.remove("username");
    prefs.remove("shareCode");
  }
}
