import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/components/rounded_button.dart';
import 'package:shar/logic/apis/delete_message.dart';
import 'package:shar/logic/apis/get_messages_api.dart';
import 'package:shar/user_page/user_page.dart';

class MessagePage extends StatefulWidget {
  final String? username;
  final String? sharecode;
  MessagePage({
    Key? key,
    required this.username,
    required this.sharecode,
  }) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late Future data;
  @override
  void initState() {
    super.initState();
    data = getMessages();
  }

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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(57, 0, 82, 1),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                  child: Column(
                    children: [
                      Text(
                        widget.username!,
                        style: GoogleFonts.londrinaSolid(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(252, 222, 156, 1),
                            fontSize: 30,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                        future: data,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            UserMessages returnedData = snapshot.data;
                            if (returnedData.messages!.length == 0) {
                              return Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                      size: 150,
                                    ),
                                    Text(
                                      'No message yet, recieve a message using your share code:',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.londrinaSolid(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SelectableText(
                                      widget.sharecode!,
                                      style: GoogleFonts.londrinaSolid(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                              );
                            }
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: returnedData.messages!.length,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        returnedData.messages![index].content!,
                                        style: GoogleFonts.londrinaSolid(
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "- Anonymous [${returnedData.messages![index].created.toString()}]",
                                        style: GoogleFonts.londrinaSolid(
                                          textStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                252, 222, 156, 1),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                deleteMessage(
                                                  messageId: returnedData
                                                      .messages![index].id
                                                      .toString(),
                                                  username: widget.username!,
                                                  sharecode: widget.sharecode!,
                                                );
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(top: 3),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    width: 1.0,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                child: Text(
                                                  'Delete',
                                                  style:
                                                      GoogleFonts.londrinaSolid(
                                                    textStyle: TextStyle(
                                                      color: Colors.white,
                                                      letterSpacing: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            Get.snackbar(
                              'Error',
                              'Unable to get messages',
                              margin: EdgeInsets.all(20),
                              duration: Duration(milliseconds: 2000),
                              colorText: Colors.white,
                              snackStyle: SnackStyle.FLOATING,
                            );
                            return SizedBox(
                              height: Get.height / 2,
                            );
                          }
                          return SizedBox(
                            height: Get.height / 2,
                          );
                        },
                      ),
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
      ),
    );
  }
}
