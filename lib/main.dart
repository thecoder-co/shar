import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shar/domain/shared_preference.dart';
import 'package:shar/login/login_page.dart';
import 'package:shar/message/message_screen.dart';
import 'package:shar/send_message/send_message.dart';
import 'package:shar/signup/opening_page.dart';

import 'package:shar/signup/signup_page.dart';
import 'package:shar/user_page/user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shar Anonymous Messages',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(),
      ),
      //unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () {
            if (UserPreferences.isLoggedIn()) {
              return MainUserPage();
            } else {
              return OpenPage();
            }
          },
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignupPage(),
        ),
        GetPage(
          name: '/home',
          page: () => MainUserPage(),
        ),
        GetPage(
          name: '/send_message/:user',
          page: () => SendMessagePage(),
        ),
        GetPage(
          name: '/get_messages',
          page: () => MessagePage(),
        ),
      ],
    );
  }
}
