import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/rounded_button.dart';
import '../send_message/find_user.dart';
import '../signup/signup_page.dart';

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
                        'asset/logo.png',
                      ),
                      backgroundColor: Colors.transparent,
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
                  AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText(
                        'Recieve anonymous messages from anyone without them having an account',
                        textStyle: GoogleFonts.londrinaSolid(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        transitionHeight: 140,
                        duration: Duration(milliseconds: 1000),
                      ),
                      RotateAnimatedText(
                        'Make anonymous message games in your group chat',
                        textAlign: TextAlign.center,
                        textStyle: GoogleFonts.londrinaSolid(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        transitionHeight: 110,
                        duration: Duration(milliseconds: 1000),
                      ),
                      RotateAnimatedText(
                        'Play confession nights with your friends',
                        textAlign: TextAlign.center,
                        textStyle: GoogleFonts.londrinaSolid(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        duration: Duration(milliseconds: 1000),
                      ),
                    ],
                    repeatForever: true,
                    pause: Duration(
                      milliseconds: 500,
                    ),
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
