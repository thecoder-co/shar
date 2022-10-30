import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/logic/controllers/user_controller.dart';
import 'package:shar/message/delete_message.dart';
import 'package:shar/message/no_messages.dart';
import 'package:shar/message/share_button.dart';
import '../components/rounded_button.dart';

import '../user_page/user_page.dart';

class MessagePage extends StatelessWidget {
  MessagePage({
    Key? key,
  }) : super(key: key);

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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(57, 0, 82, 1),
                ),
                margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
                padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                child: Column(
                  children: [
                    Obx(() => Text(
                          u.profile.value.body?.username ?? '',
                          style: GoogleFonts.londrinaSolid(
                            textStyle: TextStyle(
                              color: Color.fromRGBO(252, 222, 156, 1),
                              fontSize: 30,
                              letterSpacing: 3,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      if (u.profile.value.body?.messages == null) {
                        return Container(
                          height: Get.height / 2 + 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color.fromRGBO(252, 222, 156, 1),
                            ),
                          ),
                        );
                      } else {
                        if (u.profile.value.body!.messages!.isEmpty) {
                          return NoMessages(
                              user: u.profile.value.body!.username!);
                        } else {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: u.profile.value.body!.messages!.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: Divider(
                                  color: Color.fromRGBO(252, 222, 156, 1),
                                ),
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1.0,
                                    color: Color.fromRGBO(252, 222, 156, 1),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Message:',
                                      style: GoogleFonts.londrinaSolid(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      u.profile.value.body!.messages![index]
                                          .message!,
                                      style: GoogleFonts.londrinaSolid(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "- Anonymous [${DateTime.fromMicrosecondsSinceEpoch(u.profile.value.body!.messages![index].time!.toInt())}]",
                                      style: GoogleFonts.londrinaSolid(
                                        textStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(252, 222, 156, 1),
                                        ),
                                      ),
                                    ),
                                    ShareButton(
                                      index: index,
                                    ),
                                    DeleteButton(index: index),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      }
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton(
                      text: 'Go back',
                      press: () => Get.off(() => MainUserPage()),
                    ),
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
