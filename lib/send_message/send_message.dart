import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/logic/apis/find_user_api.dart';
import '../components/global_widgets.dart';
import '../components/rounded_button.dart';
import '../components/send_message_input.dart';
import '../logic/apis/send_message_api.dart';

class SendMessagePage extends StatefulWidget {
  SendMessagePage({
    Key? key,
  }) : super(key: key);

  @override
  _SendMessagePageState createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  String? message;

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
                  child: FutureBuilder(
                    future: findUser(
                      shareCode: Get.parameters["share_code"],
                    ),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        GetUsername data = snapshot.data;
                        return Column(
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
                              'Send an anonymous message to ${data.username}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.londrinaSolid(
                                textStyle: TextStyle(
                                  color: Color.fromRGBO(254, 248, 235, 1),
                                ),
                              ),
                            ),
                            SendMessageInputField(
                              hintText: 'Enter your message',
                              onChanged: (value) {
                                message = value;
                              },
                            ),
                            RoundedButton(
                              text: 'Send',
                              press: () {
                                if (message!.isNotEmpty) {
                                  sendMessage(
                                      shareCode: data.shareCode,
                                      message: message);
                                } else if (message!.isEmpty) {
                                  Get.snackbar(
                                    'Error',
                                    'Message is empty',
                                    margin: EdgeInsets.all(20),
                                    duration: Duration(milliseconds: 2000),
                                    colorText: Colors.white,
                                    snackStyle: SnackStyle.FLOATING,
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            children: [
                              Spacer(),
                              Icon(
                                Icons.cancel_outlined,
                                color: Colors.red,
                                size: 150,
                              ),
                              Text(
                                'User does not exist',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.londrinaSolid(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Spacer(),
                              RoundedButton(
                                text: 'Back to home',
                                press: () {
                                  Get.offAllNamed('/');
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
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
