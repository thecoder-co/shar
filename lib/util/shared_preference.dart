import 'package:shar/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  void saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("refreshToken", user.refreshToken!);
    prefs.setString("accessToken", user.accessToken!);
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? accessToken = prefs.getString("accessToken");

    String? refreshToken = prefs.getString("refreshToken");

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
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token!;
  }
}
