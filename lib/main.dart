import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:shar/signup/opening_page.dart';
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
        accentColor: Color.fromRGBO(213, 41, 65, 1),
        textTheme: TextTheme(),
      ),
      home: FutureBuilder(
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
          }),
    );
  }
}
