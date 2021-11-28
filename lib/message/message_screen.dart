import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/constants.dart';
import 'package:shar/message/share_message.dart';
import '../components/rounded_button.dart';
import '../logic/apis/delete_message.dart';
import '../logic/apis/get_messages_api.dart';
import '../user_page/user_page.dart';

class MessagePage extends StatefulWidget {
  MessagePage({
    Key? key,
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
    Map userData = Get.parameters;
    String username = userData['username'];
    String shareCode = userData['shareCode'];
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
                        username,
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
                                      "https://shar-ec801.web.app/#/send_message/$shareCode",
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
                                        "- Anonymous [${returnedData.messages![index].created!.toUtc().toLocal()}]",
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
                                              onTap: () {
                                                Get.to(ShareMessage(
                                                    message: returnedData
                                                        .messages![index]));
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(top: 3),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    width: 1.0,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Share',
                                                      style: GoogleFonts
                                                          .londrinaSolid(
                                                        textStyle: TextStyle(
                                                          color: Colors.white,
                                                          letterSpacing: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons.share,
                                                      color: Colors.green,
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                Get.defaultDialog(
                                                  backgroundColor:
                                                      kPrimaryColor,
                                                  radius: 10,
                                                  title: 'Delete?',
                                                  content: Text(
                                                    'Are you sure you want to delete message?',
                                                    style: GoogleFonts
                                                        .londrinaSolid(
                                                      textStyle: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  titleStyle:
                                                      GoogleFonts.londrinaSolid(
                                                    textStyle: TextStyle(
                                                      color: kGold,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: Text(
                                                        'No',
                                                        style: GoogleFonts
                                                            .londrinaSolid(
                                                          textStyle: TextStyle(
                                                            color: kGold,
                                                            letterSpacing: 2,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                    ),
                                                    TextButton(
                                                        child: Text(
                                                          'Yes',
                                                          style: GoogleFonts
                                                              .londrinaSolid(
                                                            textStyle:
                                                                TextStyle(
                                                              color: kGold,
                                                              letterSpacing: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          deleteMessage(
                                                            messageId:
                                                                returnedData
                                                                    .messages![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                            username: username,
                                                            sharecode:
                                                                shareCode,
                                                          );
                                                          Get.back();
                                                        }),
                                                  ],
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
                                                child: Row(
                                                  //align to center
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Delete',
                                                      style: GoogleFonts
                                                          .londrinaSolid(
                                                        textStyle: TextStyle(
                                                          color: Colors.white,
                                                          letterSpacing: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  ],
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
                              height: Get.height / 2 + 50,
                            );
                          }
                          return Container(
                            height: Get.height / 2 + 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(252, 222, 156, 1),
                              ),
                            ),
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
