import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/logic/controllers/auth_controller.dart';
import '../components/already_have_an_account_acheck.dart';
import '../components/global_widgets.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';
import '../components/rounded_password_field.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
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
                height: context.height - 100,
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
                            backgroundColor: Colors.transparent,
                            radius: 60,
                          ),
                        ),
                        Text(
                          'Login',
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
                              duration: Duration(milliseconds: 3000),
                            ),
                            RotateAnimatedText(
                              'Make anonymous message games in your group chat',
                              textAlign: TextAlign.center,
                              textStyle: GoogleFonts.londrinaSolid(
                                textStyle: TextStyle(
                                  color: Color.fromRGBO(254, 248, 235, 1),
                                ),
                              ),
                              duration: Duration(milliseconds: 3000),
                            ),
                            RotateAnimatedText(
                              'Play confession nights with your friends',
                              textAlign: TextAlign.center,
                              textStyle: GoogleFonts.londrinaSolid(
                                textStyle: TextStyle(
                                  color: Color.fromRGBO(254, 248, 235, 1),
                                ),
                              ),
                              duration: Duration(milliseconds: 3000),
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
                    RoundedInputField(
                      hintText: 'Username',
                      controller: usernameController,
                    ),
                    RoundedPasswordField(
                      text: 'Password',
                      controller: passwordController,
                    ),
                    RoundedButton(
                      text: 'Login',
                      press: () {
                        Auth.login(
                          password: passwordController.text,
                          username: usernameController.text,
                        );
                      },
                    ),
                    /* TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot your password',
                        style: GoogleFonts.londrinaSolid(
                          textStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey[850],
                    ), */
                    SizeHeight5(),
                    AlreadyHaveAnAccountCheck(
                      login: true,
                      press: () {
                        Get.offNamed('/signup');
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
