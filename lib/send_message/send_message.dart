import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/components/show_snack.dart';
import 'package:shar/logic/controllers/user_controller.dart';
import '../components/global_widgets.dart';
import '../components/rounded_button.dart';
import '../components/send_message_input.dart';

class SendMessagePage extends StatefulWidget {
  SendMessagePage({
    Key? key,
  }) : super(key: key);

  @override
  _SendMessagePageState createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  final messageController = TextEditingController();

  String? user = Get.parameters["user"];
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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
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
                      Text(
                        'Shar Anonymous Messages',
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
                        'Send an anonymous message to $user',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.londrinaSolid(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(254, 248, 235, 1),
                          ),
                        ),
                      ),
                      SendMessageInputField(
                        hintText: 'Enter your message',
                        controller: messageController,
                      ),
                      RoundedButton(
                        text: 'Send',
                        press: () {
                          if (messageController.text.isEmpty) {
                            showSnack('Enter a message');
                          }
                          if (user == null) {
                            showSnack('User not found');
                          }
                          u.sendMessage(
                            user: user!,
                            message: messageController.text,
                          );
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
