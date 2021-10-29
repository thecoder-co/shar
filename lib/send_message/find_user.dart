import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/components/global_widgets.dart';
import 'package:shar/components/rounded_button.dart';
import 'package:shar/components/rounded_input_field.dart';
import 'package:shar/logic/apis/find_user_api.dart';

class FindUser extends StatefulWidget {
  FindUser({Key? key}) : super(key: key);

  @override
  _FindUserState createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {
  String? user;
  @override
  Widget build(BuildContext context) {
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
                                'asset/avatar.png',
                              ),
                              radius: 60,
                            ),
                          ),
                          Text(
                            'Find User',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.londrinaSolid(
                              textStyle: TextStyle(
                                color: Color.fromRGBO(252, 222, 156, 1),
                                fontSize: 30,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                          SizeHeight10(),
                          Text(
                            'Find a user to send an anonymous message to',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.londrinaSolid(
                              textStyle: TextStyle(
                                color: Color.fromRGBO(254, 248, 235, 1),
                              ),
                            ),
                          ),
                          SizeHeight10(),
                          RoundedInputField(
                            hintText: 'Enter user share code',
                            onChanged: (value) {
                              user = value;
                            },
                          ),
                        ],
                      ),
                      RoundedButton(
                        text: 'Find User',
                        press: () {
                          findUser(shareCode: user);
                        },
                      ),
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
