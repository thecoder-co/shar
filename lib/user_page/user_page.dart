import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/components/rounded_button.dart';
import 'package:shar/logic/apis/get_messages_api.dart';
import 'package:shar/logic/apis/user_info.dart';
import 'package:shar/login/login_page.dart';
import 'package:shar/message/message_screen.dart';
import 'package:shar/send_message/find_user.dart';
import 'package:flutter/services.dart';
import 'package:shar/util/shared_preference.dart';

class MainUserPage extends StatefulWidget {
  MainUserPage({Key? key}) : super(key: key);

  @override
  _MainUserPageState createState() => _MainUserPageState();
}

class _MainUserPageState extends State<MainUserPage> {
  late Future<UserInfo> userInfo;
  String? shareCode;
  String? username;

  @override
  void initState() {
    super.initState();
    userInfo = getUserInfo();
  }

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
                  FutureBuilder(
                    future: userInfo,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        UserInfo data = snapshot.data;
                        shareCode = data.data!.shareCode;
                        username = data.data!.username;
                        return Text(
                          '${data.data!.username}',
                          style: GoogleFonts.londrinaSolid(
                            textStyle: TextStyle(
                              color: Color.fromRGBO(252, 222, 156, 1),
                              fontSize: 30,
                              letterSpacing: 3,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        Get.snackbar(
                          'Error',
                          'Unable to get profile details',
                          margin: EdgeInsets.all(20),
                          duration: Duration(milliseconds: 2000),
                          colorText: Colors.white,
                          snackStyle: SnackStyle.FLOATING,
                        );
                      }
                      return SizedBox(
                        height: 0,
                      );
                    },
                  ),
                  Spacer(),
                  RoundedButton(
                    text: 'Share Code',
                    press: () {
                      Clipboard.setData(ClipboardData(text: shareCode));
                      Get.snackbar(
                        'Successful',
                        'Share code copied to clipboard',
                        margin: EdgeInsets.all(20),
                        duration: Duration(milliseconds: 2000),
                        colorText: Colors.white,
                        snackStyle: SnackStyle.FLOATING,
                      );
                    },
                  ),
                  RoundedButton(
                    text: 'View Messages',
                    press: () {
                      Get.to(
                        () => MessagePage(
                          username: username!,
                          sharecode: shareCode!,
                        ),
                      );
                    },
                  ),
                  RoundedButton(
                    text: 'Find User',
                    press: () {
                      Get.to(() => FindUser());
                    },
                  ),
                  RoundedButton(
                    text: 'Log Out',
                    press: () {
                      UserPreferences().removeUser();
                      Get.off(() => LoginPage());
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
