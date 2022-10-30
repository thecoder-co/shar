import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/logic/controllers/auth_controller.dart';
import 'package:shar/logic/controllers/user_controller.dart';

import '../components/rounded_button.dart';

import 'package:flutter/services.dart';

class MainUserPage extends StatefulWidget {
  MainUserPage({Key? key}) : super(key: key);

  @override
  _MainUserPageState createState() => _MainUserPageState();
}

class _MainUserPageState extends State<MainUserPage> {
  @override
  void initState() {
    super.initState();
  }

  final u = Get.put(UserContoller());
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
                child: Obx(() {
                  if (u.profile.value.body == null) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(252, 222, 156, 1),
                      ),
                    );
                  } else {
                    String username = u.profile.value.body!.username!;
                    return Column(
                      children: [
                        Text(
                          '$username',
                          style: GoogleFonts.londrinaSolid(
                            textStyle: TextStyle(
                              color: Color.fromRGBO(252, 222, 156, 1),
                              fontSize: 30,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                        Spacer(),
                        RoundedButton(
                          text: 'Share Code',
                          press: () {
                            String link =
                                "https://shar-ec801.web.app/#/send_message/$username";
                            Clipboard.setData(ClipboardData(text: link));
                            Get.snackbar(
                              'Successful',
                              'Share code link copied to clipboard',
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
                            Get.toNamed(
                              '/get_messages',
                            );
                          },
                        ),
                        RoundedButton(
                          text: 'Log Out',
                          press: () {
                            Auth().logout();
                          },
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
