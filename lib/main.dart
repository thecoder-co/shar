import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shar/login/login_page.dart';
import 'package:shar/message/message_screen.dart';
import 'package:shar/send_message/send_message.dart';

import 'package:shar/signup/opening_page.dart';
import 'package:shar/signup/signup_page.dart';
import 'package:shar/user_page/user_page.dart';
import 'package:shar/util/shared_preference.dart';

void main() {
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
          page: () => FutureBuilder(
            future: UserPreferences().isLoggedIn(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: GoogleFonts.getFont('Overlock'),
                    );
                  } else if (snapshot.data == false) {
                    return OpenPage();
                  }
                  return MainUserPage();
              }
            },
          ),
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
          name: '/send_message/:share_code',
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
