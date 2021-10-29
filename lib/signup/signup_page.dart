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
                    'Register',
                    style: GoogleFonts.londrinaSolid(
                      textStyle: TextStyle(
                        color: Color.fromRGBO(252, 222, 156, 1),
                        fontSize: 30,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  Spacer(),
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
                        print(passwordConfirmation);
                        print(username);
                        Future data =
                            register(password: password, username: username);
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
