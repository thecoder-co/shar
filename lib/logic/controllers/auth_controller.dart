import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shar/components/dialogs.dart';
import 'package:shar/components/show_snack.dart';
import 'package:shar/domain/shared_preference.dart';
import 'package:shar/logic/apis/login.dart';
import 'package:shar/logic/apis/register.dart';

class Auth {
  static bool checkLoggedIn() {
    bool loggedIn = UserPreferences.isLoggedIn();
    return loggedIn;
  }

  static Future<void> login(
      {required final String username, required final String password}) async {
    Dialogs.loading();
    try {
      var user = await loginApi(
        username: username,
        password: password,
      );
      UserPreferences.saveToken(user.accessToken!);

      Get.back();
      Get.offAllNamed('/home');
    } catch (e) {
      Get.back();
      showSnack(e.toString());
      rethrow;
    }
  }

  static Future<void> signUp(
      {required String username, required String password}) async {
    Dialogs.loading();
    try {
      var user = await registerApi(
        username: username,
        password: password,
      );
      UserPreferences.saveToken(user.accessToken!);

      Get.back();
      Get.offAllNamed('/home');
    } catch (e) {
      Get.back();
      showSnack(e.toString());
      rethrow;
    }
  }

  logoutNoPrompt() async {
    UserPreferences.removeToken();
    Get.back();

    Get.offAllNamed('/login');
  }

  logout() {
    Get.dialog(AlertDialog(
      title: const Text(
        'Are you sure you want to logout?',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.all(10),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Cancel'),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  logoutNoPrompt();
                },
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Confirm',
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ));
    /*  */
  }
}
