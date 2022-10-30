import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/components/rounded_button.dart';
import 'package:shar/constants.dart';

import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shar/logic/apis/profile.dart';
import 'package:share_plus/share_plus.dart';

class ShareMessage extends StatelessWidget {
  final Message message;
  ShareMessage({Key? key, required this.message}) : super(key: key);

  ScreenshotController screenshotController = ScreenshotController();
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
          body: Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(57, 0, 82, 1),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
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
                            message.message!,
                            style: GoogleFonts.londrinaSolid(
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "- Anonymous [${DateTime.fromMillisecondsSinceEpoch(message.time!.toInt())}]",
                            style: GoogleFonts.londrinaSolid(
                              textStyle: TextStyle(
                                color: Color.fromRGBO(252, 222, 156, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              RoundedButton(
                text: 'Share',
                press: () async {
                  await screenshotController
                      .capture(delay: const Duration(milliseconds: 10))
                      .then((Uint8List? image) async {
                    if (image != null) {
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final imagePath =
                          await File('${directory.path}/image.png').create();
                      await imagePath.writeAsBytes(image);

                      /// Share Plugin
                      await Share.shareFiles([imagePath.path]);
                    }
                  });
                },
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
