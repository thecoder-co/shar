import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/components/already_have_an_account_acheck.dart';
import 'package:shar/components/global_widgets.dart';
import 'package:shar/components/rounded_button.dart';
import 'package:shar/components/rounded_input_field.dart';
import 'package:shar/components/rounded_password_field.dart';
import 'package:shar/logic/apis/register.dart';
import 'package:shar/login/login_page.dart';
import 'package:shar/send_message/find_user.dart';
import 'package:shar/signup/signup_page.dart';

class OpenPage extends StatefulWidget {
  OpenPage({Key? key}) : super(key: key);

  @override
  _OpenPageState createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.indigo,
                Color.fromRGBO(213, 41, 65, 1),
              ],
            ),
          ),
          child: Center(
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(57, 0, 82, 1),
              ),
              margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
              padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      child: Image.asset(
                        'asset/avatar.png',
                      ),
                      radius: 60,
                    ),
                  ),
                  Text(
                    'Shar',
                    style: GoogleFonts.londrinaSolid(
                      textStyle: TextStyle(
                        color: Color.fromRGBO(252, 222, 156, 1),
                        fontSize: 30,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Recieve anonymous messages from anyone without them having an account',
                    style: GoogleFonts.londrinaSolid(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  RoundedButton(
                    text: 'Find User',
                    press: () {
                      Get.to(() => FindUser());
                    },
                  ),
                  RoundedButton(
                    text: 'Register',
                    press: () {
                      Get.to(() => SignupPage());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
