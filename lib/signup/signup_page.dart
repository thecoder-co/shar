import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/already_have_an_account_acheck.dart';
import '../components/global_widgets.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';
import '../components/rounded_password_field.dart';
import '../logic/apis/register.dart';
import '../login/login_page.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    String username = '';
    String password = '';
    String passwordConfirmation = '';
    return SafeArea(
      child: Container(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 400,
                  height: context.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(57, 0, 82, 1),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CircleAvatar(
                              child: Image.asset(
                                'asset/logo.png',
                              ),
                              radius: 60,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Text(
                            'Register',
                            style: GoogleFonts.londrinaSolid(
                              textStyle: TextStyle(
                                color: Color.fromRGBO(252, 222, 156, 1),
                                fontSize: 30,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                          SizeHeight10(),
                          AnimatedTextKit(
                            animatedTexts: [
                              RotateAnimatedText(
                                'Send and recieve anonymous messages to anyone',
                                textAlign: TextAlign.center,
                                textStyle: GoogleFonts.londrinaSolid(
                                  textStyle: TextStyle(
                                    color: Color.fromRGBO(254, 248, 235, 1),
                                  ),
                                ),
                                duration: Duration(milliseconds: 1000),
                              ),
                              RotateAnimatedText(
                                'Make anonymous message games in your group chat',
                                textAlign: TextAlign.center,
                                textStyle: GoogleFonts.londrinaSolid(
                                  textStyle: TextStyle(
                                    color: Color.fromRGBO(254, 248, 235, 1),
                                  ),
                                ),
                                duration: Duration(milliseconds: 1000),
                              ),
                              RotateAnimatedText(
                                'Play confession nights with your friends',
                                textAlign: TextAlign.center,
                                textStyle: GoogleFonts.londrinaSolid(
                                  textStyle: TextStyle(
                                    color: Color.fromRGBO(254, 248, 235, 1),
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
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          RoundedInputField(
                            hintText: 'Username',
                            onChanged: (value) {
                              username = value;
                            },
                          ),
                          RoundedPasswordField(
                            text: 'Password',
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          RoundedPasswordField(
                            text: 'Password Confirmation',
                            onChanged: (value) {
                              passwordConfirmation = value;
                            },
                          ),
                          RoundedButton(
                            text: 'Register',
                            press: () {
                              if (password == passwordConfirmation) {
                                register(
                                    password: password, username: username);
                              } else {
                                Get.snackbar(
                                  'Error',
                                  "Passwords do not match",
                                  margin: EdgeInsets.all(20),
                                  duration: Duration(milliseconds: 2000),
                                  colorText: Colors.white,
                                  snackStyle: SnackStyle.FLOATING,
                                );
                              }
                            },
                          ),
                          SizeHeight5(),
                          AlreadyHaveAnAccountCheck(
                            login: false,
                            press: () {
                              Get.off(() => LoginPage());
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
